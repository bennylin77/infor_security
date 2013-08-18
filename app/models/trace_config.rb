# encoding: UTF-8
class TraceConfig < ActiveRecord::Base
  attr_accessible :login, :event_log, :assign, :closed
  belongs_to :adm_user
end
