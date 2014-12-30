class FireeyeLog < ActiveRecord::Base
	attr_accessible :event_level, :event_id, :malware_name, :src_ip, :dst_ip, :log_time, :receive_from
end