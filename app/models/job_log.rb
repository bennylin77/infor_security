class JobLog < ActiveRecord::Base
  attr_accessible :job_id, :log_time, :victim_ip, :threat_id, :action
  belongs_to :job
  
end
