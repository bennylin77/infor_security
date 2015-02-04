# encoding: utf-8 
require "csv"
namespace :splunk do

	desc "dump log files from splunk server"
	task :dump => :environment do
require 'net/ssh'
require 'net/ssh/shell'
		#test_cmd = "netstat"
		#host = "192.168.0.154"
		DUMP_HOSTS.each do |host|
			time_range = Time.now.ago(1.hour).strftime("%Y/%m/%d@%H")
			cmd = "ftp export log threat passive-mode equal yes start-time equal #{time_range}:00:00 end-time equal #{time_range}:59:59 to #{DUMPTO}"	
			Net::SSH.start(host, ITOP_USERNAME, :password=>ITOP_PSW) do |session|   # , :verbose=> :debug
				p cmd 
				ssh_exec!(session, cmd).inspect 
			end
		end
	end

	desc "parse log file dat to DB"
	task :parse => :environment do 
		CONSTANT_ALERT = ['alert', 'allow', 'forward', 'wildfire-upload-skip', 'wildfire-upload-success']
		outside_counts = OutsideCount.all
		outside_count_new = []
		
		job_details = JobDetail.all
		job_detail_new = []
		
		ip_maps = IpMap.all
		
		Dir.glob('/home/Gway/src/*_threat*.csv') do |rb_file|
			match1, match2 = /^(140\.113\.)/, /^(211\.76\.)/
 			CSV.foreach(rb_file, :headers => true) do |row|
 				row = row.to_hash
 				if match1.match(row["Source address"]) or match2.match(row["Source address"])
 			#		p row["Source address"] + " inside"				
 					jd = job_details.select{|jd| jd.src_ip==row["Source address"] and jd.log_date==row["Time Logged"].to_date and jd.alert==alert}.last
					unless jd.presence
						jd = job_detail_new.select{|jd| jd.src_ip==row["Source address"] and jd.log_date==row["Time Logged"].to_date and jd.alert==alert}.last
					end
					
					
					if jd.presence # new record
						jd.log_count+=1
						jd.today_count+=1
						if row["Threat/Content Type"]=='flood' or row["Threat/Content Type"]=='scan'
							jd.isflood_scan = 1
						end
						jd.save!
					else	# old record				
						ip_map = ip_maps.select{|im| im.ip ==row["Source address"]}.last
						alert = (CONSTANT_ALERT.include? row["Action"]) ? 1 : 0
						
						j = Job.new_from_splunk(row, ip_map)
						jd = JobDetail.new_from_splunk(row, alert)
						job_detail_new.push(jd)
					end
					JobLog.new_from_splunk(jd, row)
					
					
 				else # outside ip
 					findold = outside_counts.select{|oc| oc.src_ip==row["Source address"] and oc.log_date==row["Time Logged"].to_date }.last

 					if findold.presence
 						findold.sum += 1
 						findold.save!
 					else 		
 						findold = outside_count_new.select{|oc| oc.src_ip==row["Source address"] and oc.log_date==row["Time Logged"].to_date }.last				
 						if findold.presence
 							findold.sum += 1
 							findold.save!
 						else	
 							findold = outside_count_new(row)
 							outside_count_new.push(findold)
 						end
 					end
 					outside_log_new(findold.id, row)
 				end			

 			end
		end	
	end
	
	desc "just test"
	task :test => :environment do
		p "aaa"
	end

	desc "move today_count to last_count  (job_details)"
	task :move_count => :environment do 
		jds = JobDetails.all
		jds.each do |jd|
			jd.last_count = jd.today_count 
			jd.today_count = 0 
			jd.save!
		end
	end
	
private
	
	def ssh_exec!(ssh, command)
	  stdout_data = ""
	  stderr_data = ""
	  exit_code = nil
	  exit_signal = nil
	  ssh.open_channel do |channel|
		channel.send_channel_request "shell" do |ch,success|
		  unless success
			abort "FAILED: couldn't execute command (ssh.channel.exec)"
		  end
		  ch.send_data "#{command}\n"
		  channel.on_data do |ch,data|
		puts "stdout:#{data}"
			stdout_data+=data
			channel.close
		  end

		  channel.on_extended_data do |ch,type,data|
			stderr_data+=data
		puts "got stderr:#{data}"
		  end
		  channel.on_request("exit-status") do |ch,data|
			exit_code = data.read_long
		puts "EXIT-STATUS!!!\n"
		  end

		  channel.on_request("exit-signal") do |ch, data|
			exit_signal = data.read_long
		puts "EXIT-SIGNAL!!!\n"
		  end
		end
	  end
	end
	

	def outside_count_new(row)
		oc = OutsideCount.new
		oc.sum, oc.log_date = 1, row["Time Logged"].to_date
		oc.src_ip, oc.country = row["Source address"], row["Source Country"]
		oc.save!
		return oc
	end
	def outside_log_new(oc_id, row)
		ol = OutsideLog.new
		ol.outside_counts_id, ol.log_time = oc_id, row["Time Logged"].to_date
		ol.src_ip, ol.victim_ip = row["Source address"], row["Destination address"]
		ol.threat_id = row["Threat/Content Name"].scan(/.*\((.*)\)/)[0][0].to_i
		ol.action, ol.country, ol.serverity = row["Action"], row["Destination Country"], row["Severity"]
		ol.threat_type = row["Type"]
		ol.save!
	end
end
