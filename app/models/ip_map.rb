# encoding: UTF-8
class IpMap < ActiveRecord::Base
  attr_accessible  :ip, :user, :OS, :version, :place, :use, :room, :extend, :OS_others, :place_others, :use_others, :adm_user_id,
                   :campus_buildings_list_id, :IPv4_1, :IPv4_2, :IPv4_3, :IPv4_4, :block, :always_visible, :always_handle
  belongs_to :adm_user
  belongs_to :campus_buildings_list
  has_many   :jobs 
  
  validates :IPv4_1, :numericality => { :only_integer => true, :greater_than_or_equal_to=> 0, :less_than_or_equal_to=>255, :message=>"IP數字範圍為0~255" }
  validates :IPv4_2, :numericality => { :only_integer => true, :greater_than_or_equal_to=> 0, :less_than_or_equal_to=>255, :message=>"IP數字範圍為0~255" } 
  validates :IPv4_3, :numericality => { :only_integer => true, :greater_than_or_equal_to=> 0, :less_than_or_equal_to=>255, :message=>"IP數字範圍為0~255" }
  validates :IPv4_4, :numericality => { :only_integer => true, :greater_than_or_equal_to=> 0, :less_than_or_equal_to=>255, :message=>"IP數字範圍為0~255" }         
=begin  
  validates :user, :presence =>{:message => "使用者/管理者不能空白"}
  validates :fill_in_adm_user_id, :presence =>{:message => "填表人員不能空白"}
  validates :adm_user_id, :presence =>{:message => "網管人員不能空白"}
  validates :OS, :presence =>{:message => "作業系統不能空白"}
  validates :version, :presence =>{:message => "版本不能空白"}
  validates :place, :presence =>{:message => "類別不能空白"}
  validates :use, :presence =>{:message => "用途不能空白"}
  validates :room, :presence =>{:message => "房間號碼不能空白"}
  validates :extend, :presence =>{:message => "分機不能空白"}
  validates :extend, :numericality => { :only_integer => true, :message=>"分機必須為數字" } 
  
  #validate :ipRangeChecking
  validate :othersChecking
  
  def othersChecking
    if self.OS=="其它"
      if self.OS_others.blank?
        errors.add(:OS_others, "請輸入您的作業系統說明")
      end
    end
    if self.place=="其它"
      if self.place_others.blank?
        errors.add(:place_others, "請輸入您的類別說明")
      end
    end    
    if self.use=="其它"
      if self.use_others.blank?
        errors.add(:use_others, "請輸入您的使用說明")
      end
    end 
  end
  
  def ipRangeChecking
    self.ip.split('.').each do |i|
      i.to_i
    end  
        @ip_map.ip.split('.').each_with_index do|value, index|      
  end  
=end
      

  attr_accessor :ip1
  attr_accessor :ip2
  attr_accessor :ip3
  attr_accessor :ip4


end
