class Job < ActiveRecord::Base
  attr_accessible :assigning_adm_user_id, :handling_adm_user_id, :stage1, :stage2, :stage3, :stage4, :stage5, :deleted, 
                  :ip_map_id, :PA, :closing_adm_user_id
                  
  belongs_to :ip_map 
   
  has_many :job_logs
  has_many :job_threats
  has_one  :job_detail
  
  has_one  :s_check
  has_one  :s_assign
  has_one  :s_closed
  has_one  :s_handle
  has_one  :s_inform

end
