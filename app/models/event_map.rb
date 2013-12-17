class EventMap < ActiveRecord::Base
  attr_accessible :chinese_description, :chinese_name, :description, :suggestion, :thread_id, :name , :threat_type
  has_many :event_adm_logs
end
