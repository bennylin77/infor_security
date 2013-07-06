# encoding: UTF-8
class SHandle < ActiveRecord::Base
  attr_accessible  :job_id, :handling_description, :feedback
  belongs_to :job
  
  validates :handling_description, :presence =>{:message => "IP使用人處理記錄 不能是空白"}, :on=>:update
end
