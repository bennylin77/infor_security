# encoding: utf-8
class SystemMailer < ActionMailer::Base
  default :from=>"資安通報系統 <inforsec@nctu.edu.tw>"
  helper ApplicationHelper
  helper MainHelper 
#================================================================================================================================for account  
  
  def sendVerification(email, id, verify_code)
      @id=id
      @verify_code=verify_code
      mail( to: email , subject:"資安通報系統 會員系統 邀請函")
  end
  def sendResetingPw(email, new_pw)
    @email=email
    @new_pw=new_pw
    mail( to: email , subject:"資安通報系統 會員系統 密碼重設")    
  end
#================================================================================================================================for stage    
  def assignJobSending(receiver, job)
      @receiver=receiver
      @job=job      
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 新的資安事件工作")
  end
  
  def informUserSending(receiver, job)
      @receiver=receiver
      @job=job          
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 新的資安事件通知")
  end
  
  def specInform(email, job)
  	@job = job
  	mail( to: email , subject:"資安事件ID:"+@job.id.to_s+" 通知")
  end
  
  def handleJobSending(receiver, job)
      @receiver=receiver
      @job=job          
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 網管處理完成通知")
  end
  
  def checkJobSending(receiver, job)
      @receiver=receiver
      @job=job          
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 資安事件結案通知")
  end
  
  def closeJobSending(receiver, job)
      @receiver=receiver
      @job=job          
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 資安事件已結案通知")
  end
  
  def returnJobSending(job, content, stage_from=nil)
    @content=content
    @job=job
    if stage_from=='stage2'
      @receiver=AdmUser.find(@job.assigning_adm_user_id)
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 工作退回通知")      
    elsif  stage_from=='stage3'  
      @receiver=AdmUser.find(@job.handling_adm_user_id)      
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 工作退回通知")   
    elsif  stage_from=='stage4'
      @receiver=@job.ip_map.adm_user      
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 工作退回通知")       
    elsif  stage_from=='stage5'    
      @receiver=AdmUser.find(@job.handling_adm_user_id)                        
      mail( to: @receiver.email , subject:"資安事件ID:"+@job.id.to_s+" 工作退回通知")           
    end    
  end
#================================================================================================================================for comment 
  
  def sendComment(receiver, comment)
      @receiver=receiver
      @comment=comment
      mail( to: receiver.email , subject:"資安通報系統 意見回饋通知")
  end
  
  def commentAssign(receiver, comment)
	    @receiver=receiver
      @comment=comment
      mail( to: receiver.email , subject:"資安通報系統 意見回饋通知")	
  end
  
  def commentHandle(receiver, comment)
	    @receiver=receiver
      @comment=comment
      mail( to: receiver.email , subject:"資安通報系統 意見回饋通知")	
  end
  
  def commentHandleChange(receiver, comment)
	    @receiver=receiver
      @comment=comment
      mail( to: receiver.email , subject:"資安通報系統 意見回饋通知")	
  end
  
  def commentClose(receiver, comment)
	    @receiver=receiver
      @comment=comment
      mail( to: receiver.email , subject:"資安通報系統 意見回饋通知")	
  end
  
  def commentReturn(receiver, comment)
	    @receiver=receiver
      @comment=comment
      mail( to: receiver.email , subject:"資安通報系統 意見回饋通知")	
  end
#================================================================================================================================for auto mail  

  def dailyAssignMailSending(receiver, job)
    @receiver=receiver    
    @job=job    
    mail( to: @receiver.email , subject:"資安通報系統 資安事件'未指派工作'通知")
  end
  
  def dailyInformMailSending(receiver, job)
    @receiver=receiver    
    @job=job
    mail( to: @receiver.email , subject:"資安通報系統 資安事件'未通知網管'通知")
  end  
  
  def dailyHandleMailSending(receiver, job)
    @receiver=receiver    
    @job=job
    mail( to: @receiver.email , subject:"資安通報系統 資安事件'未處理事件'通知")
  end  
    
#============================================================================================
 def meetingmail(receiver)
	@receiver=receiver 
	@Res=JobDetail.find(:all,:joins=>:job,:conditions=>['((alert=1 and log_count>=1000) or (alert=0 and log_count>=5)) and jobs.always_handle=1 and jobs.deleted=0 and job_details.updated_at>= ?',DateTime.now.since(7.day)])
	@Res_all=JobDetail.find(:all,:joins=>:job,:conditions=>['((alert=1 and log_count>=1000) or (alert=0 and log_count>=5)) and jobs.always_handle=1 and jobs.deleted=0 and job_details.updated_at>= ?','2013-05-01 00:00:00'])

	mail( to: 'u9510606@gmail.com', subject:"資安通報系統 資安會議通知")
	 #@receiver.email
 end
 	
	def dailyStatistics(emails)
		@time = Time.now.ago(1.day)
		@jds = JobDetail.where('updated_at BETWEEN ? AND ? ',@time.strftime('%F 00:00:00'), @time.strftime('%F 23:59:59'))
		mail( to: emails , subject:"資安事件通報系統 - 每日處理事件IP")
	end
	
end



