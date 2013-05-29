# encoding: UTF-8
class SInform < ActiveRecord::Base
  attr_accessible :job_id, :description_alternation, :name_alternation, :suggestion_alternation, :informed_at, :log_level
  belongs_to :job
  
  validates :log_level, :presence =>{:message => "Log判讀等級 不能是空白"}, :on=>:update

end
