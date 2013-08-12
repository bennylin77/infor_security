class StatisticsController < ApplicationController
include StatisticsHelper

def index
end
def create
	@date=params[:chbox][:category]
	
	ip_trans
	
	
	if params[:chtime][:category]=='1'   #target time
		@Res=JobDetail.find(:all,:joins=>:job,:conditions=>['((alert=1 and log_count>=1000) or (alert=0 and log_count>=5)) and jobs.always_handle=1 and jobs.deleted=0 and job_details.updated_at>= ? and job_details.updated_at<=? and src_ip REGEXP ?',DateTime.strptime(params[:d1], "%m/%d/%Y %H:%M").to_datetime,DateTime.strptime(params[:d2], "%m/%d/%Y %H:%M").to_datetime,params[:ip1]+'\.'+params[:ip2]+'\.'+params[:ip3]+'\.'+params[:ip4]])
	else			#for all
		@Res=JobDetail.find(:all,:joins=>:job,:conditions=>['((alert=1 and log_count>=1000) or (alert=0 and log_count>=5)) and jobs.always_handle=1 and jobs.deleted=0 and src_ip REGEXP ?',params[:ip1]+'\.'+params[:ip2]+'\.'+params[:ip3]+'\.'+params[:ip4] ])
	end	

	
	ip_trans_back
	
    render "showRes"
end

def showRes
	
end


end
