class Comment < ActiveRecord::Base
  attr_accessible :adm_user_id, :content, :subject
  belongs_to :adm_user
end
