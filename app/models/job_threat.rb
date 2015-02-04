class JobThreat < ActiveRecord::Base
  attr_accessible :job_id, :threat_id, :serverity 
  belongs_to :job
  
	def self.new_from_splunk(job_id, threat_id, serverity)
		unless self.where(:job_id=>job_id, :threat_id=>threat_id).last.presence
			jt = self.new
			jt.job_id, jt.threat_id, jt.serverity = job_id, threat_id, serverity
			jt.save!
		end	
	end
end
