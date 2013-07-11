class Announcement < ActiveRecord::Base
  attr_accessible :subject, :content, :adm_user_id, :start_show, :end_show
end
