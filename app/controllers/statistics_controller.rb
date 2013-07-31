class StatisticsController < ApplicationController
include StatisticsHelper

def index
end
def create
	@date=params[:chbox][:category]
	
	ip_trans
	
	if params[:chbox][:category]=='0'     #by stage 
		if params[:chtime][:category]=='1'   #target time
			@Res=JobDetail.find(:all,:joins=>:job,:conditions=>['((jobs.always_visible=1) or (alert=1 and log_count>=1000) or (alert=0 and log_count>=5)) and jobs.always_handle=1 and job_details.updated_at>= ? and job_details.updated_at<=? and src_ip REGEXP ?',DateTime.strptime(params[:d1], "%m/%d/%Y %H:%M").to_datetime,DateTime.strptime(params[:d2], "%m/%d/%Y %H:%M").to_datetime,params[:ip1]+'\.'+params[:ip2]+'\.'+params[:ip3]+'\.'+params[:ip4]])
		else			#for all
			@Res=JobDetail.find(:all,:joins=>:job,:conditions=>['((jobs.always_visible=1) or (alert=1 and log_count>=1000) or (alert=0 and log_count>=5)) and (jobs.always_handle=1) and src_ip REGEXP ?',params[:ip1]+'\.'+params[:ip2]+'\.'+params[:ip3]+'\.'+params[:ip4] ])
		end	
	else #by department 	
	end
    render "showRes"
end

def showRes
	
end


end
