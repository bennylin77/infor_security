class PermissionConfig < ActiveRecord::Base
  attr_accessible :account, :adm_user_id, :building, :event, :ip, :job, :comment
  belongs_to :adm_user  
end
