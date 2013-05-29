class EventAdmLog < ActiveRecord::Base
   attr_accessible :edit_at, :event_map_id
   belongs_to :adm_user   
   belongs_to :event_map
end
