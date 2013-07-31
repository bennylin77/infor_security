class AnnouncementsController < ApplicationController

  before_filter(:only => [:new]) { |c| c.checkPermission('announcement', Infor::Application.config.CREATE_PERMISSION)}
  before_filter(:only => [:update]) { |c| c.checkUser('announcement_update', Infor::Application.config.UPDATE_PERMISSION,params[:id])}
  before_filter(:only => [:destory]) { |c| c.checkPermission('announcement', Infor::Application.config.DELETE_PERMISSION)}
  
  before_filter(:only => [:admShow]) { |c| c.checkPermission('announcement', Infor::Application.config.READ_PERMISSION)}
  
	def index
		@notice=params[:notice]
		@announcementsAll= Announcement.all
		@announcements=Array.new
		@announcementsAll.each do |a|
		  @announcements.push(a) if (a.start_show.compare_with_coercion(Time.zone.now.to_date)== 0 || a.end_show.compare_with_coercion(Time.zone.now.to_date)== 0) || (a.start_show.compare_with_coercion(Time.zone.now.to_date)== -1 && a.end_show.compare_with_coercion(Time.zone.now.to_date)== 1)
		 
		end
		
	end
	def guest
		@notice=params[:notice]
		@announcementsAll= Announcement.all
		@announcements=Array.new
		@announcementsAll.each do |a|
		  @announcements.push(a) if (a.start_show.compare_with_coercion(Time.zone.now.to_date)== 0 || a.end_show.compare_with_coercion(Time.zone.now.to_date)== 0) || (a.start_show.compare_with_coercion(Time.zone.now.to_date)== -1 && a.end_show.compare_with_coercion(Time.zone.now.to_date)== 1)
		 
		end
		
	end
	def show
		@announcement= Announcement.find(params[:id])
	end
	def edit
		@announcement= Announcement.find(params[:id])
	end
	def new
		@announcement=Announcement.new
	end
	def create
		@announcement = Announcement.new(params[:announcement])
		
		@announcement.save 
		redirect_to @announcement
	end
	def update
    @announcement = Announcement.find(params[:id])

    respond_to do |format|
      if @announcement.update_attributes(params[:announcement])
        format.html { redirect_to @announcement, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
    end
	
	def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy

    respond_to do |format|
      format.html { redirect_to announcements_url }
      format.json { head :no_content }
    end
    end
  
	def editShow
		@announcements= Announcement.find_all_by_adm_user_id(session[:adm_user_id])
	end
	
	def admShow
	  @announcements= Announcement.all
	end
	
	
end
