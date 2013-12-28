class StatisticsController < ApplicationController
include StatisticsHelper

def index
	@Res=JobDetail.find(:all,:joins=>:job,:conditions=>['((alert=1 and log_count>=1000) or (alert=0 and log_count>=5)) and jobs.always_handle=1 and jobs.deleted=0 and job_details.updated_at>= ?',DateTime.now.ago(7.day)])

end
def create
	@date=params[:chbox][:category]
	
	ip_trans
	
	
	if params[:chtime][:category]=='1'   #target time
		@Res=JobDetail.find(:all,:joins=>:job,:conditions=>['((alert=1 and log_count>=1000) or (alert=0 and log_count>=5)) and jobs.always_handle=1 and jobs.deleted=0 and job_details.updated_at>= ? and job_details.updated_at<=? and src_ip REGEXP ?',DateTime.strptime(params[:d1], "%m/%d/%Y %H:%M").to_datetime,DateTime.strptime(params[:d2], "%m/%d/%Y %H:%M").to_datetime,params[:ip1]+'\.'+params[:ip2]+'\.'+params[:ip3]+'\.'+params[:ip4]])
	else			#for all
		@Res=JobDetail.find(:all,:joins=>:job,:conditions=>['((alert=1 and log_count>=1000) or (alert=0 and log_count>=5)) and jobs.always_handle=1 and jobs.deleted=0 and job_details.updated_at>= ? and src_ip REGEXP ?','2013-05-01 00:00:00',params[:ip1]+'\.'+params[:ip2]+'\.'+params[:ip3]+'\.'+params[:ip4] ])
	end	

	
	ip_trans_back
	
    render "showRes"
end

def long_stat 
  @ary_m = Array.new
  @ary_y = Array.new
  for i in 0..11
   time = Time.now.ago(i.month)
   @ary_m << time.month
   @ary_y << time.year
  end
  
  @flag = 0
 
  if request.post?
  @flag=1
  @d_mon = params[:month]
  date1 = '2013-'+params[:month].to_s+'-01'
  @d1 = Time.strptime(date1, "%Y-%m-%d").to_time
  @d2 = @d1.since(1.month)
  @res = JobThreat.find(
                        :all,
                        :select => 'threat_id ,count(*) total',
                        :group => 'threat_id',
                        :conditions => ["updated_at>? and updated_at<?",@d1,@d2],
                        :order => 'total DESC',
                        :limit => 10)
  
  @victim = JobLog.find(
                      :all,
                      :select => 'victim_ip ,count(*) total',
                      :group => 'victim_ip',
                      :conditions => ["log_time>? and log_time<? ",@d1,@d2],
                      :order => 'total DESC',
                      :limit => 10)
   
  @source = JobLog.find(
                      :all,
                      :joins => "LEFT JOIN `job_details` ON job_details.job_id = job_logs.job_id",
                      :select => 'src_ip ,count(*) total',
                      :group => 'src_ip',
                      :conditions => ["log_time>? and log_time<? ",@d1,@d2],
                      :order => 'total DESC',
                      :limit => 10)                                                          
                        
  end    
                    
end

def top10
  @flag = 0
  if request.post?
  @flag=1
  @start = Date.new(2013,5,1)
  @d1 = Time.strptime(params[:dp1],"%Y/%m/%d %H:%M")
  
  if @d1 < @start
    @d1 = @start
  end
  
  @d2 = Time.strptime(params[:dp2],"%Y/%m/%d %H:%M")
  @res = JobLog.find(
                        :all,
                        :select => 'threat_id ,count(*) total',
                        :group => 'threat_id',
                        :conditions => ["log_time BETWEEN ? AND ?",@d1,@d2],
                        :order => 'total DESC',
                        :limit => 10)
  end

end

def show_chart

  @elapsed = ((Time.strptime(params[:d2],"%Y-%m-%d") - Time.strptime(params[:d1],"%Y-%m-%d"))/24.hour).round    # DAY
  @threat_map = EventMap.where("thread_id=?",params[:threat_id]).first
  if @threat_map.blank?
     @threat_name = ""
  else
     @threat_name = @threat_map.name || ""
  end 
  
  if @elapsed > 92

  @elapsed = ((Time.strptime(params[:d2],"%Y-%m-%d %H:%M") - Time.strptime(params[:d1],"%Y-%m-%d %H:%M"))/24.hour).round    # DAY
  @threat_name = EventMap.where("thread_id=?",params[:threat_id]).first.name.to_s
  elsif @elapsed > 180  #  over 6 months

     @res = JobLog.find(:all,
                     :select=>'MONTH(log_time) AS t,count(*) total',
                     :group=> 't',
                     :conditions => ["threat_id=? and log_time between ? and ?",params[:threat_id],params[:d1],params[:d2]],
                     :order => 't ASC')
    @type = 2   
  
  elsif @elapsed >30   #30 ~ 180
  
    @res = JobLog.find(:all,
                     :select=>'DAYOFWEEK(log_time) AS t,count(*) total',
                     :group=> 't',
                     :conditions => ["threat_id=? and log_time between ? and ?",params[:threat_id],params[:d1],params[:d2]],
                     :order => 't ASC')
    @type = 1                 
  elsif @elapsed == 1    # <1
    @res = JobLog.find(:all,
                     :select=>'HOUR(log_time) AS t,count(*) total',
                     :group=> 't',
                     :conditions => ["threat_id=? and log_time between ? and ?",params[:threat_id],params[:d1],params[:d2]])   
    @type = 777   
  else   #    1 ~ 30
    @res = JobLog.find(:all,
                     :select=>'HOUR(log_time) AS t,count(*) total',
                     :group=> 't',
                     :conditions => ["threat_id=? and log_time between ? and ?",params[:threat_id],params[:d1],params[:d2]])   
    @type = 0                                  
  end                  
                     
end


def showRes
	
end

def self.MeetingMail
	@adm_users=AdmUser.joins(:mail_config).where('meeting_notification=1')	
	SystemMailer.meetingmail(@adm_users).deliver
end



end
