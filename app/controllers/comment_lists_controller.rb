#encoding: utf-8
class CommentListsController < ApplicationController
	def index	
		@notice=params[:notice]
		@comment = Comment.paginate(:per_page => 30, :page => params[:page]).order('id DESC')
	end
	def CommentDetailShow
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
				SystemMailer.Comment_assign(adm_user, @comment).deliver
				redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'成功指派工作'
			else
				@comment.report=params[:result]
				@comment.stage=4
				@comment.save!
				redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'已結案'
			end
		end
	end
	def handle_edit
		@comment = Comment.find(params[:id])
		@adm_user=AdmUser.find(session[:adm_user_id])
		
		if request.post?
			@comment.handle_note=params[:content]   # 寫入handle_note
			@comment.stage = 3						# next stage
			@comment.save!			
			
			adm_user=AdmUser.find(params[:adm_id])
			SystemMailer.Comment_handle(adm_user, @comment).deliver
			
			redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'完成事件處理' 
		end
	end
	def change_handle_edit
		@comment = Comment.find(params[:id])
		@assign_user=AdmUser.joins(:permission_config).where('comment & 64 = 64')
		if request.post?
			@comment.handling_adm_user_id = params[:assigned_user_change]  # 換人
			@comment.change_note = params[:result]       # 換人原因
			@comment.stage = 2									
			@comment.save!
			
			adm_user=AdmUser.find(params[:assigned_user_change])
			SystemMailer.Comment_handle_change(adm_user, @comment).deliver			
				
			redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'成功指派工作'
		end
	end
	
	def closed_edit 
		@comment = Comment.find(params[:id])
		@adm_user=AdmUser.find(session[:adm_user_id])
		
		if request.post?
			@comment.report=params[:result] 	# 寫入report
			@comment.stage = 4					# next stage
			@comment.save!
			
			adm_user=AdmUser.find(params[:adm_id])
			SystemMailer.Comment_close(adm_user, @comment).deliver
			
			redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'完成事件處理' 
		end
	end
	def return_edit
		@comment = Comment.find(params[:id])
		@adm_user=AdmUser.find(session[:adm_user_id])
		
		if request.post?
			@comment.adm_note=params[:content] 	# 寫入report
			@comment.stage = 2						# return stage
			@comment.save!
			
			adm_user=AdmUser.find(params[:adm_id])
			SystemMailer.Comment_return(adm_user, @comment).deliver
			
			redirect_to :controller=>'comment_lists', :action=>'index', :notice=>'完成事件退回' 
		end
	end
end
