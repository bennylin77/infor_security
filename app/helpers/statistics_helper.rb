module StatisticsHelper

def show_ip(jobs)
	html='<table><tr><th>IP</th></tr>'
	jobs.each do |j|
		html+='<tr><td>'+j.src_ip+'</td></tr>'
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
	
	##
	params[:test]=0
	##
	jobs.each do |j|
			if j.job.stage5=='finish'
				params[:finish]+=1
			elsif j.job.stage4=='finish'  # on stage5
				params[:st5] +=1
			elsif j.job.stage3=='finish'  # on stage4
				params[:st4] +=1
			elsif j.job.stage2=='finish'  # on stage3
				params[:st3] +=1
			elsif j.job.stage1=='finish'  # on stage2
				params[:st2] +=1	
			elsif j.job.stage1=='un'      # on stage2
				params[:un]  +=1
			else
				params[:finish]=params[:finish]  # ?
			end	
			
			params[:test]+=1
	end		
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
