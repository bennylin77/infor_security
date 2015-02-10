# encoding: UTF-8
class JobDetail < ActiveRecord::Base
  attr_accessible :job_id, :log_count, :log_date, :region, :src_ip, :alert
  belongs_to :job
  belongs_to :job_log
  validates :log_count, :presence =>{:message => "事件被記錄次數"}
  validates :log_date, :presence =>{:message => "事件發生時間"}
  validates :src_ip, :presence =>{:message => "事件來源端IP Address"}    
 
 
	def self.new_from_splunk(row, alert)
	
		jd = JobDetail.new
		jd.src_ip, jd.alert = row["Source address"], alert
		jd.log_date, jd.region = row["Time Logged"], row["Source Zone"]
		jd.log_count, jd.today_count = 1, 1
		if row["Threat/Content Type"]=='flood' or row["Threat/Content Type"]=='scan'
			jd.isflood_scan = 1
		end
		jd.save! 
		
		return jd
	end
	
	def update_count
		self.log_count +=1
		self.today_count +=1
		self.save!
		
	end
	
	def check_to_system
		unless job_id # 
			
		end
	end
	
end
