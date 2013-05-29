# encoding: UTF-8
class SAssign < ActiveRecord::Base
  attr_accessible  :job_id, :feedback
  belongs_to :job
 
end
