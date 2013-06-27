class Comment < ActiveRecord::Base
  attr_accessible :adm_user_id, :content, :subject, :stage, :handling_adm_user_id, 
				  :assigning_adm_user_id, :report, :adm_note, :handle_note
  belongs_to :adm_user
end
