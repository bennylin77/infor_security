class Job < ActiveRecord::Base
  attr_accessible :assigning_adm_user_id, :handling_adm_user_id, :stage1, :stage2, :stage3, :stage4, :stage5, :deleted, 
                  :ip_map_id, :PA, :closing_adm_user_id, :always_handle , :always_visible , :from
                  
  belongs_to :ip_map 

  has_many :job_logs
  has_many :job_threats
  has_one  :job_detail
  
  has_one  :s_check
  has_one  :s_assign
  has_one  :s_closed
  has_one  :s_handle
  has_one  :s_inform

	def self.new_from_splunk(row, ip_map)
		j = self.new
		j.stage1,j.stage2,j.stage3,j.stage4,j.stage5 = 'un','un','un','un','un'
		j.ip_map_id = ip_map.try(:id)
		j.always_visible, j.always_handle = (ip_map.try(:always_visible)||0), (ip_map.try(:always_handle)||1)
		j.save!
		return j
	end
	
end
