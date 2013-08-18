class PermissionConfig < ActiveRecord::Base
  attr_accessible :account, :adm_user_id, :building, :event, :ip, :job, :comment, :announcement, :adm_user_group_id
  belongs_to :adm_user  
  belongs_to :adm_user_group
end
