# encoding: UTF-8
require 'securerandom'
class MainController < ApplicationController
  
  before_filter(:only => [:createUser]) { |c| c.checkPermission('acc', Infor::Application.config.CREATE_PERMISSION)}    
  before_filter(:only => [:mailConfig, :permissionConfig, :traceConfig, :pwReset]) { |c| c.checkPermission('acc', Infor::Application.config.UPDATE_PERMISSION)}   

  #before_filter(:only => [:permissionConfig]) { |c| c.checkingPermission('acc', Infor::Application.config.DELETE_PERMISSION)} 
  before_filter(:only => [:createJob]) { |c| c.checkPermission('job', Infor::Application.config.CREATE_PERMISSION)}    
  before_filter(:only => [:deleteJob]) { |c| c.checkPermission('job', Infor::Application.config.DELETE_PERMISSION)}  
  before_filter(:only => [:closeJob, :closeJobMail]) { |c| c.checkPermission('job', Infor::Application.config.CLOSE_PERMISSION)} 
  before_filter(:only => [:assignJob]) { |c| c.checkPermission('job', Infor::Application.config.ASSIGN_PERMISSION)}  
  before_filter(:only => [:handleJob, :handleJobMail]) { |c| c.checkUser('job_ip_map_adm', nil, params[:id])} 
  before_filter(:only => [:informUser, :informUserMail, :checkJob, :checkJobMail]) { |c| c.checkUser('job_handling_adm', nil, params[:id])}   

  before_filter(:only => [:index, :unShowing]) { |c| c.admLoginLog()}


#================================================================================================================================for menu  
  def index
    @notice=params[:notice]
    adm_user=AdmUser.find(session[:adm_user_id])
    if adm_user.permission_config.job & Infor::Application.config.READ_PERMISSION != 0 
      @jobs = Job.paginate(:per_page => 50, :page => params[:page], :conditions => [" stage1 = 'finish' and stage5 <> 'finish' and deleted = ? ", false]).order('id DESC')   
    else   
      @jobs = Job.paginate(:per_page => 50, :page => params[:page], :conditions => ["(handling_adm_user_id = ? or adm_user_id = ? ) and ( stage1 = 'finish' and stage5 <> 'finish' and deleted = ? )", session[:adm_user_id], session[:adm_user_id], false ], :joins => "left outer join ip_maps on ip_maps.id = jobs.ip_map_id").order('id DESC')         
    end   
  end     
  
  def unShowing
    @notice=params[:notice]
    adm_user=AdmUser.find(session[:adm_user_id])
    if adm_user.permission_config.job & Infor::Application.config.READ_PERMISSION != 0 
      @jobs = Job.paginate(:per_page => 50, :page => params[:page], :conditions => ["( ( (stage1 = 'un' or stage1 = 'returned') and stage5 = 'un' and deleted = ?) and ( (log_count >= 5 and alert <> ?) or (log_count >= 1000 and alert <> ?) or PA = ? ) )", false, true, false, false], :joins => :job_detail).order('id DESC')
    else
      redirect_to :controller=>'main', :action=>'index', :notice=>'您沒有權限'   
    end     
  end
  
  def finishShowing
    @notice=params[:notice]
    adm_user=AdmUser.find(session[:adm_user_id])
    if adm_user.permission_config.job & Infor::Application.config.READ_PERMISSION != 0 
      @jobs = Job.paginate(:per_page => 50, :page => params[:page], :conditions => ["stage5 = 'finish' and deleted = ?", false]).order('id DESC')
    else
      @jobs = Job.paginate(:per_page => 50, :page => params[:page], :conditions => ["(handling_adm_user_id = ? or adm_user_id = ?) and stage5 = 'finish' and deleted = ?", session[:adm_user_id], session[:adm_user_id], false], :joins => "left outer join ip_maps on ip_maps.id = jobs.ip_map_id").order('id DESC')
    end     
  end
#================================================================================================================================for comment  
  def comment 
    if request.post?               
      @comment=Comment.new(params[:comment])
      @comment.adm_user=AdmUser.find(session[:adm_user_id])
	  @comment.stage=1
      @comment.save!
     
      @adm_user = AdmUser.joins(:permission_config).where('comment_top = 1')
	  @adm_user.each do |j|	       
		SystemMailer.sendComment(j, @comment).deliver                   	  
	  end
            
      redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'已將您寶貴的意見送出'
    else
      @comment=Comment.new
    end     
  end
  
    
#================================================================================================================================for stage  
  def jobDetailShowing
    @job=Job.find(params[:id])     
    if @job.s_assign.nil?
      @job.s_assign=SAssign.new
      @job.save!
    end
    if @job.s_inform.nil?
      @job.s_inform=SInform.new
      @job.save!
    end
    if @job.s_handle.nil?
     @job.s_handle=SHandle.new
     @job.save!
    end
    if @job.s_check.nil?
     @job.s_check=SCheck.new
     @job.save!
    end
    if @job.s_closed.nil?
     @job.s_closed=SClosed.new
     @job.save!
    end 
    if @job.ip_map.blank?                                                    # find adm user of job
      ip_map=IpMap.find_by_ip(@job.job_detail.src_ip)
      if !ip_map.blank?
        @job.ip_map=ip_map
        @job.save!
      end
    end       
  end
  
  def assignJob
    @engineers=AdmUser.joins(:permission_config).where('job & 64 <> 0')
    
    @job=Job.find(params[:id])
    if @job.s_assign.nil?
      @job.s_assign=SAssign.new
      @job.save!
    end
    if @job.s_inform.nil?
      @job.s_inform=SInform.new
      @job.save!
    end
    if @job.s_handle.nil?
     @job.s_handle=SHandle.new
     @job.save!
    end
    if @job.s_check.nil?
     @job.s_check=SCheck.new
     @job.save!
    end
    if @job.s_closed.nil?
     @job.s_closed=SClosed.new
     @job.save!
    end
    
    if request.post?               
      if !params[:assigned_user].blank?
        @job.s_assign.save!
        @assigned_user=AdmUser.find(params[:assigned_user])  
        @job.stage1="finish"
        @job.stage2="processing"        
        @job.handling_adm_user_id=@assigned_user.id
        @job.assigning_adm_user_id=session[:adm_user_id] 
        @job.s_assign.done_at=Time.now  
        @job.s_assign.save!
        @job.save!
        SystemMailer.assignJobSending(@assigned_user, @job).deliver 
        redirect_to :controller=>'main', :action=>'index', :notice=>'成功指派工作' 
      else 
        @job.stage1="un"
        @job.stage2="un"  
        @job.handling_adm_user_id=nil
        @job.assigning_adm_user_id=nil
        @job.save!  
        redirect_to :controller=>'main', :action=>'index'        
      end
    end  
  end
  
  def informUser
    @job=Job.find(params[:id])   
    if @job.ip_map.blank?                                                    # find adm user of job
      ip_map=IpMap.find_by_ip(@job.job_detail.src_ip)
      if !ip_map.blank?
        @job.ip_map=ip_map
        @job.save!
      end
    end
  end
  
  def informUserMail
    @job=Job.find(params[:id]) 
    if !@job.ip_map.blank?
      if !@job.ip_map.adm_user.blank?      
        if !@job.s_inform.log_level.blank?
          SystemMailer.informUserSending(@job.ip_map.adm_user, @job).deliver 
          if @job.s_inform.informed_at.blank?
            @job.s_inform.informed_at=Time.now
          end
          @job.s_inform.done_at=Time.now 
          @job.stage2="finish"
          @job.stage3="processing"
          @job.s_inform.save!
          @job.save!
          @notice='成功送出通知信'
        else   
          @notice='請填寫 Log判讀等級'        
        end 
      else   
        @notice='此IP無對應網管資訊'       
      end         
    else
      @notice='此IP無對應網管資訊' 
    end  
    render "informUser"     
  end
      
  def handleJob
    @job=Job.find(params[:id])
  end
  
  def handleJobMail
    @job=Job.find(params[:id]) 
    if !@job.s_handle.handling_description.blank? 
      adm_user=AdmUser.find(@job.handling_adm_user_id)
      SystemMailer.handleJobSending(adm_user, @job).deliver 
      @job.stage3="finish"
      @job.stage4="processing"
      @job.s_handle.done_at=Time.now 
      @job.s_handle.save!
      @job.save!
      @notice='成功送出通知信'
    else
      @notice='請填寫 IP使用人處理記錄'      
    end  
    render "handleJob" 
  end
  
  def checkJob
    @job=Job.find(params[:id])
  end
  
  def checkJobMail
    @job=Job.find(params[:id]) 
    adm_users=AdmUser.joins(:permission_config).where('job & 32 <> 0')
    adm_users.each do |a|
      SystemMailer.checkJobSending(a, @job).deliver 
    end
    @job.stage4="finish"
    @job.stage5="processing"
    @job.s_check.done_at=Time.now 
    @job.s_check.save!
    @job.save!
    @notice='成功送出通知信'
    render "checkJob" 
  end
  
  def closeJob
    @job=Job.find(params[:id])
  end
  
  def closeJobMail
    @job=Job.find(params[:id]) 
    adm_user=@job.ip_map.adm_user
    handling_adm_user=AdmUser.find(@job.handling_adm_user_id)
    assigning_adm_user=AdmUser.find(@job.assigning_adm_user_id)   
    #SystemMailer.closeJobSending(adm_user, @job).deliver 
    SystemMailer.closeJobSending(handling_adm_user, @job).deliver
    SystemMailer.closeJobSending(assigning_adm_user, @job).deliver    
    @job.closing_adm_user_id=session[:adm_user_id] 
    @job.stage5="finish"
    @job.s_closed.done_at=Time.now 
    @job.s_closed.save!    
    @job.save!
    @notice='成功送出通知信'
    render "closeJob" 
  end  
  
  def returnJob
    @job=Job.find(params[:id]) 
    @stage=params[:returned_stage]
    if request.post? 
      if  @stage=='stage1'
        @job.stage2="un"
        @job.stage1="returned"
        @job.s_assign.done_at=nil                 
        @job.s_assign.save!
        @job.handling_adm_user_id=nil
        @job.save!
        SystemMailer.returnJobSending(@job, params[:content], 'stage2').deliver           
      elsif  @stage=='stage2'
        @job.stage3="un"
        @job.stage2="returned"
        @job.s_assign.done_at=Time.now        
        @job.s_inform.done_at=nil  
        @job.s_assign.save!                     
        @job.s_inform.save!
        SystemMailer.returnJobSending(@job, params[:content], 'stage3').deliver                   
      elsif  @stage=='stage3'
        @job.stage4="un"
        @job.stage3="returned"
        @job.s_inform.done_at=Time.now          
        @job.s_handle.done_at=nil 
        @job.s_inform.save!                     
        @job.s_handle.save!
        SystemMailer.returnJobSending(@job, params[:content], 'stage4').deliver                  
      elsif  @stage=='stage4'
        @job.stage5="un"
        @job.stage4="returned"      
        @job.s_handle.done_at=Time.now 
        @job.s_check.done_at=nil  
        @job.s_handle.save!
        @job.s_check.save!
        SystemMailer.returnJobSending(@job, params[:content], 'stage5').deliver                   
      end
      @job.save!
      redirect_to :controller=>'main', :action=>'index', :notice=>'成功退回工作' 
    end          
  end
  
  def createJob  
    if params[:notice]
      @notice=params[:notice]
    end
    
    if request.post?               
      job=Job.new(:stage1=>'un', :stage2=>'un', :stage3=>'un', :stage4=>'un', :stage5=>'un', :PA=>false)      
      ip_map=IpMap.find_by_ip(params[:src_ip])
      job.ip_map=ip_map     
      job_detail=JobDetail.new(:log_date=>DateTime.strptime(params[:log_date], "%m/%d/%Y").to_date, :src_ip=>params[:src_ip],
                               :alert=>params[:alert], :log_count=>params[:log_count], :region=>params[:region])
      job_detail.job=job
      job_detail.save!     
      if !params[:threat].blank?
        params[:threat].each do |key, value|
          threat=params[:threat][key]
          j_log=JobLog.new( :threat_id=>threat[:id], :log_time=>DateTime.strptime(threat[:log_time], "%m/%d/%Y %H:%M"), :victim_ip=>threat[:victim_ip] )
          if params[:alert]=='true'
            j_log.action='alert'
          else  
            j_log.action='non-alert'
          end
          j_log.job=job
          j_log.save!
          
          j_threat=JobThreat.where("job_id = ? and threat_id = ?", job.id ,threat[:id] )
          
          if !j_threat.any?
            j_threat=JobThreat.new( :threat_id=>threat[:id], :serverity=>threat[:serverity])
            j_threat.job=job
            j_threat.save!
          end         
        end
      end
      redirect_to :controller=>'main', :action=>'index', :notice=>'成功新增資安事件' 
    end 
    rescue ActiveRecord::RecordInvalid
      job_detail.valid? 
      redirect_to :controller=>'main', :action=>'createJob', :notice=>'輸入錯誤'              
  end
  
  def deleteJob
    job = Job.find(params[:id])
    job.deleted=true
    job.deleted_at=Time.now
    job.save!  
    redirect_to :back
  end

  
#================================================================================================================================for account

  def createUser 
    if request.post?
      @adm_user=AdmUser.new(:email=>params[:email], :verify_code=>SecureRandom.hex(5), :verified=>false,
                            :department=>params[:department] ,:name=>params[:name] ,:campus_buildings_list_id=>params[:campus_buildings_list_id], 
                            :phone=>params[:phone], :extend=>params[:extend] )                              
      @adm_user.save! 
      @mail_config=MailConfig.new       
      @mail_config.adm_user=@adm_user
      @mail_config.save!     
      @permission_config=PermissionConfig.new        
      @permission_config.adm_user=@adm_user
      @permission_config.save!   
      @trace_config=TraceConfig.new
      @trace_config.adm_user=@adm_user
      @trace_config.save! 
                   
      SystemMailer.sendVerification(params[:email], @adm_user.id, @adm_user.verify_code).deliver 
      redirect_to :controller=>'main', :action=>'index', :notice=>'成功送出帳號邀請函'
    end
   
    rescue ActiveRecord::RecordInvalid
      @adm_user.valid?     
      render :action=>:createUser  
  end
  
  def login
     session[:adm_user_id]=nil
     if request.post?
      user=AdmUser.authenticate(params[:username],params[:password])
       if user
         session[:adm_user_id]=user.id
         uri=session[:original_uri]
         session[:original_uri]=nil
         redirect_to ( uri|| {:controller=>'main', :action=>'index'} )
       else
         flash.now[:notice]="錯誤的帳號或密碼"
       end
     end
  end

  def logout
    session[:adm_user_id]=nil
    flash[:notice]="已經登出"
    redirect_to :controller=>"main" ,:action=>"index" 
  end
  
  def mailConfig
    if request.post?               
      @mail_config = MailConfig.find(params[:mail_config][:id]) 
      @mail_config.meeting_notification = params[:meeting_notification]
      @mail_config.weekly_statistic = params[:weekly_statistic]
      @mail_config.save!
      redirect_to adm_users_url          
    else
      @mail_config = MailConfig.find_by_adm_user_id(params[:id])  
    end      
  end
  
  def permissionConfig
    if request.post?               
      @permission_config = PermissionConfig.find(params[:permission_config][:id])              
      @permission_config.account =  params[:acc_read].to_i | params[:acc_update].to_i | params[:acc_create].to_i | params[:acc_delete].to_i
      @permission_config.ip =  params[:ip_read].to_i | params[:ip_update].to_i | params[:ip_create].to_i | params[:ip_delete].to_i      
      @permission_config.event =  params[:event_read].to_i | params[:event_update].to_i | params[:event_create].to_i | params[:event_delete].to_i
      @permission_config.building =  params[:building_read].to_i | params[:building_update].to_i | params[:building_create].to_i | params[:building_delete].to_i
      @permission_config.job =  params[:job_read].to_i | params[:job_handle].to_i | params[:job_assign].to_i | params[:job_close].to_i | params[:job_create].to_i | params[:job_delete].to_i            

	@permission_config.comment = params[:comment_web_worker].to_i
	@permission_config.comment_top = params[:comment_top].to_i

      @permission_config.save!
      redirect_to adm_users_url          
    else
      @permission_config = PermissionConfig.find_by_adm_user_id(params[:id])  
    end   
  end 
  
  def traceConfig
    if request.post?               
      @trace_config = TraceConfig.find(params[:trace_config][:id]) 
      @trace_config.login = params[:login]
      @trace_config.event_log = params[:event_log]
      @trace_config.assign = params[:assign]
      @trace_config.closed = params[:closed]
      
      @trace_config.save!
      redirect_to adm_users_url          
    else
      @trace_config = TraceConfig.find_by_adm_user_id(params[:id])  
    end      
  end   
  
  def pwReset
    adm_user=AdmUser.find(params[:id])
    new_pw = SecureRandom.hex(5)
    adm_user.pw= new_pw
    adm_user.pw_confirmation= new_pw
    logger.info new_pw
    adm_user.save!
    SystemMailer.sendResetingPw(adm_user.email, new_pw).deliver 
    redirect_to adm_users_url 
  end
#================================================================================================================================for auto mail  
  def self.dailyMail
    @jobs=Job.find(:all, :conditions => [" deleted = ? and ( (log_count >= 5 and alert <> ?) or (log_count >= 1000 and alert <> ?) )", false, true, false], :joins => :job_detail) 
    @jobs.each do |j| 
      if (j.stage1=='un' or j.stage1=='returned') and j.stage5=='un'     
        if (Time.now - j.created_at.in_time_zone('UTC') )/60/60/24 > 3    
          adm_users=AdmUser.joins(:permission_config).where('job & 16 <> 0')
          adm_users.each do |a|
            SystemMailer.dailyAssignMailSending(a, j ).deliver   
          end
        end          
      elsif !j.s_assign.done_at.blank? and (j.stage2=='processing' or j.stage2=='returned')        
        if  (Time.now - j.s_assign.done_at )/60/60/24 > 3
          a=AdmUser.find(j.handling_adm_user_id)
          SystemMailer.dailyInformMailSending(a, j ).deliver
        end                 
      elsif !j.s_inform.done_at.blank? and (j.stage3=='processing' or j.stage3=='returned')
        if (Time.now - j.s_inform.done_at )/60/60/24 > 3
          SystemMailer.dailyHandleMailSending(j.ip_map.adm_user, j ).deliver
        end                                                  
      end
    end    
  end

#================================================================================================================================= protected  
protected
  
  def admLoginLog
    @adm_login_log=AdminLoginLog.new
    @adm_login_log.adm_user=AdmUser.find_by_id(session[:adm_user_id])
    @adm_login_log.login_at=Time.now    
    @adm_login_log.save!    
  end
  
end
