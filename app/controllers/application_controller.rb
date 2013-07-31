# encoding: UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery :secret => 'c29b46d85562c4cc0f87acb482a2200d'
  before_filter :authorize, :except=> [:login, :verifyCode, :update, :show, :guest ]
  
  
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
	elsif type=='comment'        
      unless (adm_user.permission_config.comment & permission) != 0
        redirect_to :controller=>'main', :action=>'index', :notice=>'您沒有權限'      
      end 	
	elsif type=='announcement'
	  unless (adm_user.permission_config.announcement & permission) != 0
	    redirect_to :controller=>'announcements', :action=>'index', :notice=>'您沒有權限'      
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
      if !job.ip_map.nil?
        if  job.ip_map.adm_user!=adm_user        
          redirect_to :controller=>'main', :action=>'index', :notice=>'您沒有權限'
        end
      else
        redirect_to :controller=>'main', :action=>'index', :notice=>'尚未登入 IP對照表'        
      end
    elsif type=='job_handling_adm'     
      job = Job.find(id)      
      if  job.handling_adm_user_id!=adm_user.id      
          redirect_to :controller=>'main', :action=>'index', :notice=>'您沒有權限'
      end               
	elsif type=='comment_handle'     
      comment = Comment.find(id)      
      if  comment.handling_adm_user_id!=adm_user.id      
          redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'您沒有權限'
      end  
	elsif type=='comment_change_handle'     
      comment = Comment.find(id)      
      if  comment.assigning_adm_user_id!=adm_user.id and comment.handling_adm_user_id!=adm_user.id     
          redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'您沒有權限'
      end  	  
    elsif type=='comment_close'     
      comment = Comment.find(id)      
      if  comment.assigning_adm_user_id!=adm_user.id      
          redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'您沒有權限'
      end  		
	elsif type=='comment_pre_edit'     
      comment = Comment.find(id)      
      if  comment.adm_user_id!=adm_user.id or comment.stage!="1"   
          redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'您沒有權限'
      end  	
    elsif type=='announcement_update'
      if  adm_user.permission_config.announcement & permission == 0	
		announcement = Announcement.find(id)      
		if  announcement.adm_user_id!=adm_user.id      
          redirect_to :controller=>'announcements', :action=>'editShow', :notice=>'您沒有權限'
		end 
	  end
	end
  end   
  
  
protected
  def authorize
    unless AdmUser.find_by_id(session[:adm_user_id])
      session[:original_uri]=request.url
      flash[:notice]="請先登入,謝謝!"
      redirect_to :controller=> :main, :action=> :login
	  #redirect_to :controller=> :announcements, :action=> :index
    end
  end   
end
