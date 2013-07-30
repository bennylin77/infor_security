class AdmUserGroup < ActiveRecord::Base
  attr_accessible :account, :name, :building, :event, :ip, :job, :comment
  has_many :permission_configs  
end