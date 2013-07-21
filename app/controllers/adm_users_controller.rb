# encoding: UTF-8
class AdmUsersController < ApplicationController
  
  before_filter(:only => [:destory]) { |c| c.checkPermission('acc', Infor::Application.config.DELETE_PERMISSION)}
  before_filter(:only => [:groupIndex, :groupCreate, :groupEdit, :groupDestroy]) { |c| c.checkPermission('acc', Infor::Application.config.UPDATE_PERMISSION)}  
  before_filter(:only=>[:edit, :update, :show]) { |c| c.checkUser('acc', Infor::Application.config.UPDATE_PERMISSION)}    
  # before_filter(:only => [:index]) { |c| c.checkPermission('acc', Infor::Application.config.READ_PERMISSION)}   

  def verifyCode
    @adm_user=AdmUser.find(params[:id])
    if @adm_user.verify_code==params[:verify_code]&&!@adm_user.verified
      session[:adm_user_id]=@adm_user.id
      redirect_to :controller=>'adm_users', :action=>'edit', :id=>params[:id]   
    else 
      redirect_to :controller=>'main', :action=>'index' 
    end
  end
  
  def index   
    @adm_users = AdmUser.all
  end

  def show
    @adm_user = AdmUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @adm_user }
    end
  end

  def edit
    @adm_user = AdmUser.find(params[:id])    
  end

  def update
    @adm_user = AdmUser.find(params[:id])
    
    @adm_user.update_attributes!(params[:adm_user])
    if !@adm_user.verified
      @adm_user.verified=true
    end
    @adm_user.save!
    redirect_to @adm_user, notice: '成功編輯!'
    
    rescue ActiveRecord::RecordInvalid
      @adm_user.valid? 
      render :action=>:edit
  end

  def destroy
    @adm_user = AdmUser.find(params[:id]) 
    
    Job.where('assigning_adm_user_id = ?', params[:id]).each do |j|   
      j.stage1='un'
      j.stage2='un'
      j.stage3='un'             
      j.stage4='un'
      j.stage5='un' 
      j.handling_adm_user_id=nil
      j.assigning_adm_user_id=nil
      j.save
      if !j.s_assign.nil?
        j.s_assign.destroy
      end
      if !j.s_inform.nil?
        j.s_inform.destroy
      end
      if !j.s_handle.nil?
        j.s_handle.destroy
      end
      if !j.s_check.nil?
        j.s_check.destroy
      end
      if !j.s_closed.nil?
        j.s_closed.destroy
      end                    
    end        
       
    Job.where('handling_adm_user_id = ?', params[:id]).each do |j|
      j.stage1='un'
      j.stage2='un'
      j.stage3='un'             
      j.stage4='un'
      j.stage5='un' 
      j.handling_adm_user_id=nil
      j.assigning_adm_user_id=nil
      j.save
      if !j.s_assign.nil?
        j.s_assign.destroy
      end
      if !j.s_inform.nil?
        j.s_inform.destroy
      end
      if !j.s_handle.nil?
        j.s_handle.destroy
      end
      if !j.s_check.nil?
        j.s_check.destroy
      end
      if !j.s_closed.nil?
        j.s_closed.destroy
      end                
    end  
    @adm_user.ip_maps.clear
    @adm_user.comments.clear
  
    @adm_user.mail_config.destroy
    @adm_user.permission_config.destroy
    @adm_user.trace_config.destroy
    @adm_user.destroy

    respond_to do |format|
      format.html { redirect_to adm_users_url }
      format.json { head :no_content }
    end
  end
  
  def groupIndex
    @adm_user_groups=AdmUserGroup.all
  end
  
  def groupCreate
    if request.post?               
      @adm_user_group = AdmUserGroup.new(:name=>params[:name])              
      @adm_user_group.account =  params[:acc_read].to_i | params[:acc_update].to_i | params[:acc_create].to_i | params[:acc_delete].to_i
      @adm_user_group.ip =  params[:ip_read].to_i | params[:ip_update].to_i | params[:ip_create].to_i | params[:ip_delete].to_i      
      @adm_user_group.event =  params[:event_read].to_i | params[:event_update].to_i | params[:event_create].to_i | params[:event_delete].to_i
      @adm_user_group.building =  params[:building_read].to_i | params[:building_update].to_i | params[:building_create].to_i | params[:building_delete].to_i
      @adm_user_group.job =  params[:job_read].to_i | params[:job_handle].to_i | params[:job_assign].to_i | params[:job_close].to_i | params[:job_create].to_i | params[:job_delete].to_i            
      @adm_user_group.comment = params[:comment_web_worker].to_i | params[:comment_top].to_i | params[:comment_read].to_i   #comment
      @adm_user_group.save!
      redirect_to :controller=>:adm_users, :action=>:groupIndex
    else
      @adm_user_group=AdmUserGroup.new        
    end   
  end 
  
  def groupEdit 
    if request.post?               
      @adm_user_group = AdmUserGroup.find(params[:adm_user_group][:id])
      @adm_user_group.name =  params[:name]             
      @adm_user_group.account =  params[:acc_read].to_i | params[:acc_update].to_i | params[:acc_create].to_i | params[:acc_delete].to_i
      @adm_user_group.ip =  params[:ip_read].to_i | params[:ip_update].to_i | params[:ip_create].to_i | params[:ip_delete].to_i      
      @adm_user_group.event =  params[:event_read].to_i | params[:event_update].to_i | params[:event_create].to_i | params[:event_delete].to_i
      @adm_user_group.building =  params[:building_read].to_i | params[:building_update].to_i | params[:building_create].to_i | params[:building_delete].to_i
      @adm_user_group.job =  params[:job_read].to_i | params[:job_handle].to_i | params[:job_assign].to_i | params[:job_close].to_i | params[:job_create].to_i | params[:job_delete].to_i            
      @adm_user_group.comment = params[:comment_web_worker].to_i | params[:comment_top].to_i | params[:comment_read].to_i   #comment
      @adm_user_group.save!
      redirect_to :controller=>:adm_users, :action=>:groupIndex          
    else
      @adm_user_group = AdmUserGroup.find(params[:id])  
    end    
  end
  
  def groupDestroy
    
  end
  
  
  
       
end
