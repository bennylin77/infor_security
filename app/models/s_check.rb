class SCheck < ActiveRecord::Base
  attr_accessible :description, :job_id, :status
  belongs_to :job
  
  attr_accessor :status
end
