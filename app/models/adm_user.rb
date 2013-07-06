# encoding: UTF-8
require 'digest/sha1'
class AdmUser < ActiveRecord::Base
  attr_accessible :email, :extend, :name, :phone, :pw, :username, :pw_confirmation, :verify_code, :department, :verified, :campus_buildings_list_id
  has_many :jobs
  
  has_many :event_adm_logs  
  has_many :admin_login_logs   
  
  has_many :ip_maps 
  has_many :comments, :dependent=>:destroy    
  has_one  :mail_config
  has_one  :permission_config   
  has_one  :trace_config     
  belongs_to :campus_buildings_list
  
  attr_accessor :pw_confirmation 
    
  validates :name, :presence =>{:message => "姓名 不能是空白"}
  validates :username, :uniqueness =>{ :message =>"帳號 已經使用過" }, :presence => { :message =>"帳號 不能是空白" }, :on=>:update
  validates :email, :presence =>{:message => "email 不能是空白"}
  validates :department, :presence =>{:message => "單位/系所 不能是空白"}
  validates :campus_buildings_list_id, :presence =>{:message => "單位系所位置 不能是空白"}
  validates :phone, :presence =>{:message => "聯絡電話 不能是空白"}
  validates :extend, :presence =>{:message => "分機 不能是空白"}

  
  validates :pw, :presence =>{:message => "密碼 不能是空白"}, :confirmation =>{:message => "密碼 輸入不一致"}, :on=>:update
  validates :pw_confirmation, :presence =>{:message => "密碼確認 不能是空白"}, :on=>:update

  
#=========================================================================for pw
  def pw
    @pw
  end
 
  def pw=(pwd)
    @pw=pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_pw=AdmUser.encrypted_password(self.pw,self.salt)
  end

  def self.authenticate(username,password)
    user=self.find_by_username(username)
    if user
      expected_password=encrypted_password(password,user.salt)
      if user.hashed_pw!=expected_password
        user=nil
      end
    end
    user
  end
  
 
private


  def create_new_salt
    self.salt = self.object_id.to_s+rand.to_s
  end

  def self.encrypted_password(password,salt)
    string_to_hash=password+"infor2012"+salt
    Digest::SHA1.hexdigest(string_to_hash)
  end  
  
  
end
