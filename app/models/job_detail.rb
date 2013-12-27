# encoding: UTF-8
class JobDetail < ActiveRecord::Base
  attr_accessible :job_id, :log_count, :log_date, :region, :src_ip, :alert
  belongs_to :job
  
  validates :log_count, :presence =>{:message => "事件被記錄次數"}
  validates :log_date, :presence =>{:message => "事件發生時間"}
  validates :src_ip, :presence =>{:message => "事件來源端IP Address"}    
 
end
