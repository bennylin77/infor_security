# encoding: UTF-8
module ApplicationHelper

	def current_user
		AdmUser.find(session[:adm_user_id])
	end
  def domainIp
    "http://140.113.27.249"
  end
  
  def domainName
    "http://inforsecurity.it.nctu.edu.tw"
  end  
  
  def permissionRead(re)
    if Infor::Application.config.READ_PERMISSION & re != 0
      true
    else
      false
    end  
  end
  
  def permissionUpdate(up)
    if Infor::Application.config.UPDATE_PERMISSION & up != 0
      true
    else
      false
    end    
  end
  
  def permissionCreate(cr)
    if Infor::Application.config.CREATE_PERMISSION & cr != 0
      true
    else
      false
    end    
  end  
  
  def permissionDelete(de)
    if Infor::Application.config.DELETE_PERMISSION & de != 0
      true
    else
      false
    end    
  end   
  
  def permissionAssign(as)
    if Infor::Application.config.ASSIGN_PERMISSION & as != 0
      true
    else
      false
    end    
  end 
  
  def permissionClose(cl)
    if Infor::Application.config.CLOSE_PERMISSION & cl != 0
      true
    else
      false
    end    
  end  
  
  def permissionHandle(ha)
    if Infor::Application.config.HANDLE_PERMISSION & ha != 0
      true
    else
      false
    end    
  end       
  
  def checkingAuth (session_adm_id)
    adm_user=AdmUser.find(session_adm_id)
    adm_user.authorization=="adm"
  end 
  
	def job_status_msg(job)
		
		if job.stage5 != 'un'
			'已結案'
		elsif job.stage4 != 'un'
			'工程師完成確認中'
		elsif job.stage3 != 'un'
			'網管處理事件中'
		elsif job.stage2 != 'un'
			'工程師通知網管中'
		elsif job.stage1 != 'un'	
			'管理員指派工程師中'
		else
			'尚未處理'
		end
	end 
end
