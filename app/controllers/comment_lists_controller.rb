#encoding: utf-8
class CommentListsController < ApplicationController

	before_filter(:only => [:index, :commentDetailShow]) { |c| c.checkPermission('comment', Infor::Application.config.READ_PERMISSION)}    
	before_filter(:only => [:handleEdit]) { |c| c.checkUser('comment_handle',nil,params[:id])}    
	before_filter(:only => [:closeEdit, :returnEdit]) { |c| c.checkUser('comment_close',nil,params[:id])}    
	before_filter(:only => [:changeHandleEdit]) { |c| c.checkUser('comment_change_handle',nil,params[:id])}    

	before_filter(:only => [:preEdit]) { |c| c.checkUser('comment_pre_edit',nil,params[:id])}   
	
	def index	
		@notice=params[:notice]
		@comment = Comment.paginate(:per_page => 30, :page => params[:page]).order('id DESC')
	end
	
	def commentDetailShow
		@comment = Comment.find(params[:id])
	    @adm_user=AdmUser.find(session[:adm_user_id])
		@assign_user=AdmUser.joins(:permission_config).where('comment & 64 = 64')             
		if request.post?
			if params[:result].nil?
				@comment.assigning_adm_user_id=session[:adm_user_id]
				@comment.handling_adm_user_id =params[:assigned_user]
				@comment.stage=2
				@comment.save!
				
				adm_user=AdmUser.find(params[:assigned_user])
				SystemMailer.commentAssign(adm_user, @comment).deliver
				redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'成功指派工作'
			else	
				if params[:result].nil?
					if params[:selection]=="1"
						@comment.report='已完成'
					elsif params[:selection]=="2"	
						@comment.report='部分已完成'
					else
						@comment.report='不處理'	
					end	
				else		
					if params[:selection]=="1"
						@comment.report='已完成 '+params[:result] 	# 寫入report
					elsif params[:selection]=="2"	
						@comment.report='部分已完成 '+params[:result] 	# 寫入report
					else
						@comment.report='不處理 '+params[:result] 	# 寫入report
					end
					#@comment.report=params[:selection]+" "+params[:result] 	# 寫入report
				end
				@comment.stage=4
				@comment.assigning_adm_user_id= session[:adm_user_id]
				@comment.handling_adm_user_id= session[:adm_user_id]
				@comment.save!
				redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'已結案'
			end
		end
	end
	def handleEdit
		@comment = Comment.find(params[:id])
		@adm_user=AdmUser.find(session[:adm_user_id])
		
		if request.post?
			@comment.handle_note=params[:content]   # 寫入handle_note
			@comment.stage = 3						# next stage
			@comment.save!			
			
			adm_user=AdmUser.find(params[:adm_id])
			SystemMailer.commentHandle(adm_user, @comment).deliver
			
			redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'完成事件處理' 
		end
	end
	def changeHandleEdit
		@comment = Comment.find(params[:id])
		@assign_user=AdmUser.joins(:permission_config).where('comment & 64 = 64')
		if request.post?
			@comment.handling_adm_user_id = params[:assigned_user_change]  # 換人
			@comment.change_note = params[:result]       # 換人原因
			@comment.stage = 2									
			@comment.save!
			
			adm_user=AdmUser.find(params[:assigned_user_change])
			SystemMailer.commentHandleChange(adm_user, @comment).deliver			
				
			redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'成功指派工作'
		end
	end
	
	def closedEdit 
		@comment = Comment.find(params[:id])
		@adm_user=AdmUser.find(session[:adm_user_id])
		
		if request.post?
			if params[:result].nil?
					if params[:selection]=="1"
						@comment.report='已完成'
					elsif params[:selection]=="2"	
						@comment.report='部分已完成'
					else
						@comment.report='不處理'	
					end	
				else		
					if params[:selection]=="1"
						@comment.report='已完成 '+params[:result] 	# 寫入report
					elsif params[:selection]=="2"	
						@comment.report='部分已完成 '+params[:result] 	# 寫入report
					else
						@comment.report='不處理 '+params[:result] 	# 寫入report
					end
					#@comment.report=params[:selection]+" "+params[:result] 	# 寫入report
				end
			@comment.stage = 4					# next stage
			@comment.save!
			
			adm_user=AdmUser.find(params[:adm_id])
			SystemMailer.commentClose(adm_user, @comment).deliver
			
			redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'完成事件處理' 
		end
	end
	def returnEdit
		@comment = Comment.find(params[:id])
		@adm_user=AdmUser.find(session[:adm_user_id])
		
		if request.post?
			@comment.adm_note=params[:content] 	# 寫入report
			@comment.stage = 2						# return stage
			@comment.save!
			
			adm_user=AdmUser.find(params[:adm_id])
			SystemMailer.commentReturn(adm_user, @comment).deliver
			
			redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'完成事件退回' 
		end
	end
	
	def preEdit
		@comment = Comment.find(params[:id])
		@adm_user=AdmUser.find(session[:adm_user_id])
		
		if request.post?
			@comment.subject=params[:title] 	
			@comment.content=params[:content] 
			@comment.updated_at=Time.now	
			@comment.save!
			
			redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'完成事件修改' 
		end
	end
	
	def search         
	if params[:selection]=="0"
		@comment=Comment.paginate(:per_page => 30, :page => params[:page],  :conditions => ['id LIKE ? or subject LIKE ? or content LIKE ? ', "%#{params[:search][:term]}%", "%#{params[:search][:term]}%", "%#{params[:search][:term]}%"], :order=>['id DESC'] )    
	else
		@comment=Comment.paginate(:per_page => 30, :page => params[:page],  :conditions => ['(id LIKE ? or subject LIKE ? or content LIKE ? )and stage = ? ', "%#{params[:search][:term]}%", "%#{params[:search][:term]}%", "%#{params[:search][:term]}%", params[:selection] ], :order=>['id DESC'] )    
	end
    render "index" 
  end
end
