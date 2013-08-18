# encoding: UTF-8
class MailConfig < ActiveRecord::Base
  attr_accessible :meeting_notification, :weekly_statistic, :adm_user_id
  belongs_to :adm_user
end
