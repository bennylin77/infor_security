# encoding: utf-8
namespace :LogServer do

	desc "csv parser hourly (fireeye)"
	task :parseFireeye => :environment do # load rails environment before doing 
		flag = 0
		cnt_flag= 0
		cnt = 0
		src_flag= 0
		dst_flag= 0

		data = {}
		File.open("/var/mail/inform", "r").each_line do |line|
			res=nil
			res = line.match(/Received: by (.*) \(/)
			if res
				# save data to db & reset data
				if data[:log_time]
					@fire = FireeyeLog.new(:event_level=>data[:event_level], :event_id=>data[:event_id],
						:malware_name=>data[:malware_name], :src_ip=>data[:src_ip], :dst_ip=>data[:dst_ip],
						:log_time=>data[:log_time], :receive_from=>data[:received])		
					@fire.save!
					data.clear
				end	
		 
				# log next data	
				data[:received] = res[1]  # log time
				flag = 1
				src_flag= 0
				dst_flag= 0
				cnt_flag= 0
				next	
			end		
			res=nil
			res = line.match(/Date: (.*) \+0800/)
			if res
				data[:log_time] = Time.parse(res[1])  # log time
			end

			res = line.match(/--(.*)/)
			if res
				if res[1].include? "--" # end of log		
					flag = 0		
				end	
				next
			end	
			if flag==1 # in mail
				res = line.match(/(.*) \(id:(.*), .*/)
				if res	
					data[:event_level] = res[1].strip
					data[:event_id] = res[2]
					cnt_flag = 0
				end
				if line.include? "src:"
					src_flag = 1
				end	
				if line.include? "dst:"
					src_flag = 0
					dst_flag = 1
				end	
				if src_flag==1
					res = line.match(/.*ip: (.*)/)
					if res 
						data[:src_ip] = res[1]
						src_flag = 0
					end	
				end	
				if dst_flag==1
					res = line.match(/.*ip: (.*)/)
					if res 
						data[:dst_ip] = res[1]
						dst_flag = 0
					end	
				end	

				res = nil
				res = line.match(/malware \(name:(.*)\):/)
				if res
					data[:malware_name] = res[1]
				end	

			end	

		end
		if data[:received]
			@fire = FireeyeLog.new(:event_level=>data[:event_level], :event_id=>data[:event_id],
				:malware_name=>data[:malware_name], :src_ip=>data[:src_ip], :dst_ip=>data[:dst_ip],
				:log_time=>data[:log_time], :receive_from=>data[:received])		
			@fire.save!
		end

		# clear log content
		File.open('/var/mail/inform', 'w') {|file| file.truncate(0) }
	end
	
	desc "csv parser hourly (GOV EDU)"
	task :parseSplunk => :environment do # load rails environment before doing 
		Dir.glob('/home/eason/*_threat*.csv') do |rb_file|
 			#p rb_file
		end	
	end
	
	desc "just test"
	task :test=> :environment do
		p IpMap.find(1).IPv4_4
	end

end
