class StatisticsController < ApplicationController
include StatisticsHelper

def index
	@Res=JobDetail.find(:all,:joins=>:job,:conditions=>['((isflood_scan=1 and log_count>50) or (isflood_scan=0 and alert =0 and log_count>20) or (alert=1 and log_count >= 1000)) and jobs.always_handle=1 and jobs.deleted=0 and job_details.updated_at>= ?',DateTime.now.ago(7.day)])
	#@serverity=JobThreat.find(:all,
							  #:select=>'DISTINCT serverity as a')
	@serverity=Array.new
	@serverity.push(['informational',"informational"])
	@serverity.push(['high',"high"])
	@serverity.push(['medium',"medium"])
	@serverity.push(['low',"low"])
	@serverity.push(['critical',"critical"])

	
	
end
def create
	@date=params[:chbox][:category]
	ip_trans
	
	@ip_for_cond = params[:ip1]+'\.'+params[:ip2]+'\.'+params[:ip3]+'\.'+params[:ip4]
	@ip_org = params[:ip1]+'.'+params[:ip2]+'.'+params[:ip3]+'.'+params[:ip4]
	@specify_time = params[:chtime][:category].to_i
#	logger.debug @ip_for_cond
	@time_start = nil
	@time_end = nil		
	if @specify_time==1  #target time specify
		@time_start = DateTime.strptime(params[:d1], "%m/%d/%Y %H:%M").to_datetime
		@time_end = DateTime.strptime(params[:d2], "%m/%d/%Y %H:%M").to_datetime
		logger.debug "[DEBUG] "+params[:d1]+" to "+params[:d2]
		@Res=JobDetail.find(:all,:joins=>:job,:conditions=>['((alert=1 and log_count>=1000) or (alert=0 and log_count>=5)) and jobs.always_handle=1 and jobs.deleted=0 and job_details.updated_at BETWEEN ? and ? and src_ip REGEXP ?', @time_start, @time_end, @ip_for_cond ])
	else		
		@Res=JobDetail.find(:all,:joins=>:job,:conditions=>['((alert=1 and log_count>=1000) or (alert=0 and log_count>=5)) and jobs.always_handle=1 and jobs.deleted=0 and job_details.updated_at>= ? and src_ip REGEXP ?','2013-05-01 00:00:00',@ip_for_cond ])
	end	

	
	ip_trans_back
	
    render "showRes"
end

def long_stat   # test use
  @flag = 0
  if request.post?
    @flag=1
   
    @d1 = Time.strptime(params[:dp1],"%Y/%m/%d %H:%M")
    @d2 = Time.strptime(params[:dp2],"%Y/%m/%d %H:%M")
    
    @res = JobLog.temp(params[:dp1],params[:dp2])
    
  end
end

def top10
  @flag = 0
  if request.post?
    
    @flag=1
    @start = Date.new(2013,5,1)
	Time.zone='Taipei'
	@d1 = Time.zone.parse(params[:dp1]).advance(:hours => 8).utc
	
	
    #@d1 = Time.strptime(params[:dp1],"%Y/%m/%d %H:%M")
    
    if @d1 < @start
      @d1 = @start
    end    
    #@d2 = Time.strptime(params[:dp2],"%Y/%m/%d %H:%M")
	@d2 = Time.zone.parse(params[:dp2]).advance(:hours => 8).utc
    @beginsearchtime=Time.now
     # @res = JobLog.temp(params[:dp1],params[:dp2]) 
       @res = JobLog.find( :all,
                           :select => 'country,threat_id,SUM(1) total',
                           :group => 'threat_id',
                           :conditions => ["log_time between ? and ? ",@d1,@d2],
                           :order => 'total DESC',
                           :limit => 10) 
  	 # JobLog.temp2(params[:dp1],params[:dp2])   
  end

end

def show_chart
  @d1 = params[:d1]
  @d2 = params[:d2]
  @elapsed = ((Time.strptime(params[:d2],"%Y-%m-%d") - Time.strptime(params[:d1],"%Y-%m-%d"))/24.hour).round    # DAY
  @threat_map = EventMap.where("thread_id=?",params[:threat_id]).first
  if @threat_map.blank?
     @threat_name = ""
  else
     @threat_name = @threat_map.name || ""
  end 

  if @elapsed > 180  #  over 6 months      MONTH

     @res = JobLog.find(:all,
                     :select=>'MONTH(log_time) AS t,count(*) total',
                     :group=> 't',
                     :conditions => ["threat_id=? and log_time between ? and ?",params[:threat_id],params[:d1],params[:d2]],
                     :order => 't ASC')
     @res2 = OutsideLog.find(:all,
                     :select=>'MONTH(log_time) AS t,count(*) total',
                     :group=> 't',
                     :conditions => ["threat_id=? and log_time between ? and ?",params[:threat_id],params[:d1],params[:d2]],
                     :order => 't ASC')                
    @type = 2   
  
  elsif @elapsed >32   #30 ~ 180   7DAY
  
    @res = JobLog.find(:all,
                     :select=>'DATE_FORMAT(log_time,"%m/%d/%Y") as d,sum(1) total',
                     :group=> 'd',
                     :conditions => ["threat_id=? and log_time between ? and ?",params[:threat_id],params[:d1],params[:d2]],
                     :order => 'd ASC')
    @res2 = OutsideLog.find(:all,
                     :select=>'DATE_FORMAT(log_time,"%m/%d/%Y") AS d,sum(1) total',
                     :group=> 'd',
                     :conditions => ["threat_id=? and log_time between ? and ?",params[:threat_id],params[:d1],params[:d2]],
                     :order => 'd ASC')                 
    @type = 1                 
  elsif @elapsed == 1    # <=1     HOUR
    @res = JobLog.find(:all,
                     :select=>'HOUR(log_time) AS t,SUM(1) total',
                     :group=> 't',
                     :conditions => ["threat_id=? and log_time between ? and ?",params[:threat_id],params[:d1],params[:d2]])   
    @res2 = OutsideLog.find(:all,
                     :select=>'HOUR(log_time) AS t,SUM(1) total',
                     :group=> 't',
                     :conditions => ["threat_id=? and log_time between ? and ?",params[:threat_id],params[:d1],params[:d2]])                    
    @type = 0   
  else                  #    1 ~ 30   DATE
    @res = JobLog.find(:all,
                     :select=>'log_time as d , DATE_FORMAT(log_time,"%c/%e/%Y") AS t,count(*)  total',
                     :group=> 't',
                     :conditions => ["threat_id=? and log_time between ? and ?",params[:threat_id],params[:d1],params[:d2]],
                     :order=>"d ASC"
                     )   
    @res2 = OutsideLog.find(:all,
                     :select=>'log_time as d , DATE_FORMAT(log_time,"%c/%e/%Y") AS t,count(*) total',
                     :group=> 't',
                     :conditions => ["threat_id=? and log_time between ? and ?",params[:threat_id],params[:d1],params[:d2]],
                     :order=>"d ASC"
                     )                   
    @type = 3                                  
  end                  
                     
end


def showRes
	
end

def self.MeetingMail
	@adm_users=AdmUser.joins(:mail_config).where('meeting_notification=1')	
	SystemMailer.meetingmail(@adm_users).deliver
end



end
