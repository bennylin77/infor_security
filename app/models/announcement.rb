class Announcement < ActiveRecord::Base
  attr_accessible :subject, :content, :adm_user_id
end
