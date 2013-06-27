# encoding: UTF-8
module ApplicationHelper
  
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
  
  def permission_comment(ha)
	if ha==1
		true
	else
		false
	end
  end
   
end
