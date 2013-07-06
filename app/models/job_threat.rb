class JobThreat < ActiveRecord::Base
  attr_accessible :job_id, :threat_id, :serverity
  belongs_to :job
  
end
