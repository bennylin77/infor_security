class StatisticsController < ApplicationController

def index
end
def create
	@date=params[:d1]
	@Res=JobDetail.find(:all,:conditions=>['((alert=1 and log_count>=1000) or (alert=0 and log_count>=5)) and updated_at>= ? and updated_at<=?',DateTime.strptime(params[:d1], "%m/%d/%Y %H:%M").to_datetime,DateTime.strptime(params[:d2], "%m/%d/%Y %H:%M").to_datetime])
    render "showRes"
end

def showRes
	
end


end
