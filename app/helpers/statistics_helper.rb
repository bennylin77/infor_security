module StatisticsHelper
require 'date'

def show_ip(jobs)		# debug used
	html='<table><tr><th>ID</th><th>IP</th></tr>'
	s_time=0
	jobs.each do |j|
		html+='<tr><td>'+j.job_id.to_s+'</td><td>'+j.src_ip.to_s+'</td>'
	#	difference=((((DateTime.now - j.created_at.to_datetime)*24).to_i)+8).to_s
	#	html+='<td>'+DateTime.now.to_s+'</td>'
	#	html+='<td>'+j.created_at.to_datetime.to_s+'</td>'
	#	html+='<td>'+difference+'</td>'
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
	total=0
	##
	jobs.each do |j|
			if j.job.stage5=='finish'
				params[:finish]+=1
			elsif j.job.stage4=='finish'  # on stage5
				params[:st5] +=1
				if j.job.s_check.done_at.blank?
					t_st5+=0
				else
					t_st5+=(((DateTime.now - j.job.s_check.done_at.to_datetime)*24).to_i)+8
				end
			elsif j.job.stage3=='finish'  # on stage4
				params[:st4] +=1
				if j.job.s_handle.done_at.blank?
					t_st4+=0
				else
					t_st4+=(((DateTime.now - j.job.s_handle.done_at.to_datetime)*24).to_i)+8
				end
			elsif j.job.stage2=='finish'  # on stage3
				params[:st3] +=1
				if j.job.s_inform.done_at.blank?
					t_st3+=0
				else
					t_st3+=(((DateTime.now - j.job.s_inform.done_at.to_datetime)*24).to_i)+8
				end
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
			total+=1   #total 
	end		
	
	if params[:st2]>0
			t_st2/=params[:st2]
			if t_st2<1
				params[:avg_st2]='<1'
			else	
				params[:avg_st2]=t_st2
			end	
		end
		if params[:st3]>0	 		
			t_st3/=params[:st3]
			if t_st3<1
				params[:avg_st3]='<1'
			else	
				params[:avg_st3]=t_st3
			end	
		end
		if params[:st4]>0	
			t_st4/=params[:st4]
			if t_st4<1
				params[:avg_st4]='<1'
			else	
				params[:avg_st4]=t_st4
			end	
		end
		if params[:st5]>0	
			t_st5/=params[:st5]
			if t_st5<1
				params[:avg_st5]='<1'
			else	
				params[:avg_st5]=t_st5
			end	
		end
	
	
	total
	
end

def count_dep(jobs)
	list = LinkedList.new('nil',0)
	
	jobs.each do |j|
		if j.job.ip_map_id.blank?	
			list.add('Unknown IP',1)
		else
			if j.job.ip_map.campus_buildings_list_id.blank?
				list.add('Unknown IP',1)
			else			
				list.add(j.job.ip_map.campus_buildings_list.building_name,1)
			end
		end	
	end
	
	html=''
	current = list.re_list 
	while current.next_node != nil
		current = current.next_node
		html+='<tr><td>'+current.name.to_s+'</td><td>'+current.value.to_s+'</td></tr>'
	end
	
	html.html_safe
end

def count_total(jobs)
	total=0
	jobs.each do |j|
		total+=1
	end
	total
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

def ip_trans_back
	if params[:ip1]=='.*'
		params[:ip1]='*'
	end
	if params[:ip2]=='.*'
		params[:ip2]='*'
	end
	if params[:ip3]=='.*'
		params[:ip3]='*'
	end
	if params[:ip4]=='.*'
		params[:ip4]='*'
	end
end

def check_dep(j)
	msg=''
	if j.job.ip_map_id.blank?	
		msg='Unknown Place(place check ip_map on the web)'	
	else
		if j.job.ip_map.campus_buildings_list_id.blank?
			msg='Unknown Place(place check ip_map on the web)'	
		else			
			msg=j.job.ip_map.campus_buildings_list.building_name.to_s
		end
	end	
	msg
end

def showAllThreatsName(jobs)
	jobs.job.job_threats.each do |t|
		event = EventMap.find_by_thread_id(t.threat_id)
		if !event.nil?   
			if !event.name.blank? 
			  message=message+'('+t.threat_id.to_s+')'+event.name  
			else
			  message=message+'('+t.threat_id.to_s+')'+'--'    
			end 
			
			if !event.chinese_name.blank? 
			  message=message+'/'+event.chinese_name  
			else
			  message=message+'/'+'--'         
			end
		else
			message=message+'('+t.threat_id.to_s+')'+'--/--'   
		end     
		  message=message+'<br>'
	end
	message
end

def check_finish(job)
	if job.job.stage5=='finish'
		job.job.s_closed.done_at.to_s
	else
		'Processing'
	end
end

end
