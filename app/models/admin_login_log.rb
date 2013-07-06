class AdminLoginLog < ActiveRecord::Base
   attr_accessible :login_at
   belongs_to :adm_user  
end
