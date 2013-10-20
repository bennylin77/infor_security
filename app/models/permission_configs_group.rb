class PermissionConfigsGroup < ActiveRecord::Base
   attr_accessible :adm_user_group_id, :permission_config_id
   belongs_to :permission_config 
  
end
