class OutsideCount < ActiveRecord::Base
  attr_accessible :sum , :log_date ,:src_ip
  has_many :outside_logs
   
end
