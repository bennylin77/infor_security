class AnnouncementsController < ApplicationController
	def index
		
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
  
	def edit_show
		@announcements= Announcement.find_all_by_adm_user_id(session[:adm_user_id])
	end
	
end
