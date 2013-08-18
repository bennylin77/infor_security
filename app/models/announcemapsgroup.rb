class Announcemapsgroup < ActiveRecord::Base
  belongs_to :announcement
  belongs_to :admusergroup
  attr_accessible :adm_group_id, :announcement_id
end
