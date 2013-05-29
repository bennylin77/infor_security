# encoding: UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery :secret => 'c29b46d85562c4cc0f87acb482a2200d'
  before_filter :authorize, :except=> [:login, :verifyCode, :update, :show ]
  
  
  def domainIp
    "http://140.113.27.249"
  end
  
  def domainName
    "http://inforsecurity.it.nctu.edu.tw"
  end
  
  def checkPermission(type=nil, permission=nil)
    adm_user=AdmUser.find(session[:adm_user_id])   
    if type=='acc'
      unless (adm_user.permission_config.account & permission) != 0
        redirect_to :controller=>'main', :action=>'index', :notice=>'您沒有權限'      
      end
    elsif type=='ip'
      unless (adm_user.permission_config.ip & permission) != 0
        redirect_to :controller=>'main', :action=>'index', :notice=>'您沒有權限'      
      end      
    elsif type=='building'
      unless (adm_user.permission_config.building & permission) != 0
        redirect_to :controller=>'main', :action=>'index', :notice=>'您沒有權限'      
      end
    elsif type=='event'
      unless (adm_user.permission_config.event & permission) != 0
        redirect_to :controller=>'main', :action=>'index', :notice=>'您沒有權限'      
      end
    elsif type=='job'        
      unless (adm_user.permission_config.job & permission) != 0
        redirect_to :controller=>'main', :action=>'index', :notice=>'您沒有權限'      
      end            
    end       
  end  
  
  def checkUser(type=nil, permission=nil, id=nil)
    adm_user=AdmUser.find(session[:adm_user_id])    
    if type=='acc'     
      if  adm_user.permission_config.account & permission == 0
        if params[:id]!=session[:adm_user_id].to_s        
          redirect_to :controller=>'main', :action=>'index', :notice=>'您沒有權限'
        end
      end  
    elsif type=='ip'
      ip_map = IpMap.find(id)  
      if  adm_user.permission_config.ip & permission == 0
        if  ip_map.adm_user!=adm_user        
          redirect_to :controller=>'main', :action=>'index', :notice=>'您沒有權限'
        end
      end
    elsif type=='job_ip_map_adm'
      job = Job.find(id)  
      if  job.ip_map.adm_user!=adm_user        
          redirect_to :controller=>'main', :action=>'index', :notice=>'您沒有權限'
      end
    elsif type=='job_handling_adm'     
      job = Job.find(id)      
      if  job.handling_adm_user_id!=adm_user.id      
          redirect_to :controller=>'main', :action=>'index', :notice=>'您沒有權限'
      end               
    end 
  end   
  
protected
  def authorize
    unless AdmUser.find_by_id(session[:adm_user_id])
      session[:original_uri]=request.url
      flash[:notice]="請先登入,謝謝!"
      redirect_to :controller=>'main',:action=>'login'
    end
  end   
end
