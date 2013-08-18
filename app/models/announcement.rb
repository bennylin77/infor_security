class Announcement < ActiveRecord::Base
  has_many :announcemapsgroup
  has_many :admusergroup, :through=> :announcemapsgroup
  attr_accessible :subject, :content, :adm_user_id, :start_show, :end_show
end
