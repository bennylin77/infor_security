# encoding: utf-8
class SystemMailer < ActionMailer::Base
  default :from=>"資安通報系統 <inforsec@nctu.edu.tw>"
  helper ApplicationHelper
  
#================================================================================================================================for account  
  
  def sendVerification(email, id, verify_code)
      @id=id
      @verify_code=verify_code
      mail( to: email , subject:"資安通報系統 會員系統 邀請函", cc: "gavinhsu@nctu.edu.tw")
  end
  def sendResetingPw(email, new_pw)
    @email=email
    @new_pw=new_pw
    mail( to: email , subject:"資安通報系統 會員系統 密碼重設", cc: "gavinhsu@nctu.edu.tw")    
  end
#================================================================================================================================for stage    
  def assignJobSending(receiver, job)
      @receiver=receiver
      @job=job      
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 新的資安事件工作", cc: "gavinhsu@nctu.edu.tw")
  end
  
  def informUserSending(receiver, job)
      @receiver=receiver
      @job=job          
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 新的資安事件通知", cc: "gavinhsu@nctu.edu.tw")
  end
  
  def handleJobSending(receiver, job)
      @receiver=receiver
      @job=job          
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 網管處理完成通知", cc: "gavinhsu@nctu.edu.tw")
  end
  
  def checkJobSending(receiver, job)
      @receiver=receiver
      @job=job          
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 資安事件結案通知", cc: "gavinhsu@nctu.edu.tw")
  end
  
  def closeJobSending(receiver, job)
      @receiver=receiver
      @job=job          
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 資安事件已結案通知", cc: "gavinhsu@nctu.edu.tw")
  end
  
  def returnJobSending(job, content, stage_from=nil)
    @content=content
    @job=job
    if stage_from=='stage2'
      @receiver=AdmUser.find(@job.assigning_adm_user_id)
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 工作退回通知", cc: "gavinhsu@nctu.edu.tw")      
    elsif  stage_from=='stage3'  
      @receiver=AdmUser.find(@job.handling_adm_user_id)      
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 工作退回通知", cc: "gavinhsu@nctu.edu.tw")   
    elsif  stage_from=='stage4'
      @receiver=@job.ip_map.adm_user      
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 工作退回通知", cc: "gavinhsu@nctu.edu.tw")       
    elsif  stage_from=='stage5'    
      @receiver=AdmUser.find(@job.handling_adm_user_id)                        
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 工作退回通知", cc: "gavinhsu@nctu.edu.tw")           
    end    
  end
#================================================================================================================================for comment 
  
  def sendComment(receiver, comment)
      @receiver=receiver
      @comment=comment
      mail( to: receiver.email , subject:"資安通報系統 意見回饋通知", cc: "gavinhsu@nctu.edu.tw")
  end
#================================================================================================================================for auto mail  

  def dailyAssignMailSending(receiver, job)
    @receiver=receiver    
    @job=job    
    mail( to: @receiver.email , subject:"資安通報系統 資安事件'未指派工作'通知", cc: "gavinhsu@nctu.edu.tw")
  end
  
  def dailyInformMailSending(receiver, job)
    @receiver=receiver    
    @job=job
    mail( to: @receiver.email , subject:"資安通報系統 資安事件'未通知網管'通知", cc: "gavinhsu@nctu.edu.tw")
  end  
  
  def dailyHandleMailSending(receiver, job)
    @receiver=receiver    
    @job=job
    mail( to: @receiver.email , subject:"資安通報系統 資安事件'未處理事件'通知", cc: "gavinhsu@nctu.edu.tw")
  end  
    
end



