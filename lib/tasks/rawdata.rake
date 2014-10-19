# encoding: utf-8
namespace :rawdata do

	desc "csv parser hourly (fireeye)"
	task :parse => :environment do # load rails environment before doing 
		flag = 0
		cnt_flag= 0
		cnt = 0
		src_flag= 0
		dst_flag= 0

		data = {}
require "time"
		File.open("/var/mail/inform", "r").each_line do |line|
			res=nil
			res = line.match(/Received: by (.*) \(/)
			if res
				# save data to db & reset data
				if data[:log_time]
					@fire = FireeyeLog.new(:event_level=>data[:event_level], :event_id=>data[:event_id],
						:malware_name=>data[:malware_name], :src_ip=>data[:src_ip], :dst_ip=>data[:dst_ip],
						:log_time=>data[:log_time])		
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
				#print res[1]+"\n" 
				if not res[1].include? "--" # start to count
					cnt_flag = 1
					cnt = 0
				else
					flag = 0		
				end	
				next
			end	
			if flag==1 # in mail
				if cnt_flag==1
					cnt+=1
					if cnt==9
						res = line.match(/(.*) \(id:(.*), .*/)
						data[:event_level] = res[1].strip
						data[:event_id] = res[2]
						cnt_flag = 0
					end	
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
		@fire = FireeyeLog.new(:event_level=>data[:event_level], :event_id=>data[:event_id],
			:malware_name=>data[:malware_name], :src_ip=>data[:src_ip], :dst_ip=>data[:dst_ip],
			:log_time=>data[:log_time])		
		@fire.save!

		# clear log content
		File.open('/var/mail/inform', 'w') {|file| file.truncate(0) }
	end

end