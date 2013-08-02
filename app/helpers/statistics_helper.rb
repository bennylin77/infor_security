module StatisticsHelper
require 'date'

def show_ip(jobs)
	html='<table><tr><th>ID</th><th>IP</th></tr>'
	s_time=0
	jobs.each do |j|
		html+='<tr><td>'+j.job_id.to_s+'</td><td>'+j.src_ip.to_s+'</td>'
		difference=((((DateTime.now - j.created_at.to_datetime)*24).to_i)+8).to_s
		html+='<td>'+DateTime.now.to_s+'</td>'
		html+='<td>'+j.created_at.to_datetime.to_s+'</td>'
		html+='<td>'+difference+'</td>'
		html+='</tr>'
	end
	
	html+='</table>'
	html.html_safe
end


def count_stage(jobs)
	params[:st2]=0
	t_st2=0
	params[:st3]=0
	t_st3=0
	params[:st4]=0
	t_st4=0
	params[:st5]=0
	t_st5=0
	
	params[:un] =0	
	params[:finish]=0
	
	params[:avg_st2]=0
	params[:avg_st3]=0
	params[:avg_st4]=0
	params[:avg_st5]=0
	
	##
	params[:total]=0
	##
	jobs.each do |j|
			if j.job.stage5=='finish'
				params[:finish]+=1
			elsif j.job.stage4=='finish'  # on stage5
				params[:st5] +=1
				if j.job.s_check.done_at.to_datetime.blank?
					t_st5+=0
				else
					t_st5+=(((DateTime.now - j.job.s_check.done_at.to_datetime)*24).to_i)+8
				end
			elsif j.job.stage3=='finish'  # on stage4
				params[:st4] +=1
				t_st4+=(((DateTime.now - j.job.s_handle.done_at.to_datetime)*24).to_i)+8
			elsif j.job.stage2=='finish'  # on stage3
				params[:st3] +=1
				t_st3+=(((DateTime.now - j.job.s_inform.done_at.to_datetime)*24).to_i)+8
			elsif j.job.stage1=='finish'  # on stage2
				params[:st2] +=1	
				if j.job.s_assign.done_at.blank?
					t_st2+=0
				else	
					t_st2+=(((DateTime.now - j.job.s_assign.done_at.to_datetime)*24).to_i)+8
				end
			elsif j.job.stage1=='un'      # on stage1
				params[:un]  +=1
			else
				params[:finish]=params[:finish]  # ?
			end						
			params[:total]+=1   #total 
	end		
	
	if params[:st2]>0
			t_st2/=params[:st2]
			params[:avg_st2]=t_st2
		end
		if params[:st3]>0	 		
			t_st3/=params[:st3]
			params[:avg_st3]=t_st3
		end
		if params[:st4]>0	
			t_st4/=params[:st4]
			params[:avg_st4]=t_st4
		end
		if params[:st5]>0	
			t_st5/=params[:st5]
			params[:avg_st5]=t_st5
	end
	
	
	params[:total]
	
end

def count_dep(job)

end

def ip_trans
	if params[:ip1]=='*' or params[:ip1].blank?
		 params[:ip1]='.*'
	end
	if params[:ip2]=='*' or params[:ip2].blank?
		 params[:ip2]='.*'
	end
	if params[:ip3]=='*' or params[:ip3].blank?
		 params[:ip3]='.*'
	end
	if params[:ip4]=='*' or params[:ip4].blank?
		 params[:ip4]='.*'
	end
	
	if params[:chip][:category]=='0'
		params[:ip1]=='.*'
		params[:ip2]=='.*'
		params[:ip3]=='.*'
		params[:ip4]=='.*'
	end
	
end

end
