# encoding: UTF-8
class CampusBuildingsList < ActiveRecord::Base
  attr_accessible :building_name, :campus_name
  has_many :ip_maps
  has_many :adm_users   
  validates :campus_name, :presence =>{:message => "校區名稱 不能是空白"}
  validates :building_name, :presence =>{:message => "建築名稱 不能是空白"}
end
