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
	params[:labels] = Array.new
	params[:data] = Array.new
	jobs.each do |j|
		if j.job.ip_map_id.blank?	
			list.add('Unknown IP',1)
		else			
			if j.job.ip_map.campus_buildings_list.blank?
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
		params[:labels]<<current.name.to_s
		params[:data]<<current.value
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
		params[:ip1]='.*'
		params[:ip2]='.*'
		params[:ip3]='.*'
		params[:ip4]='.*'
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
	message = ""
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
	message.html_safe
end

def check_finish(job)
	if job.job.stage5=='finish'
		job.job.s_closed.done_at.to_s
	else
		'Processing'
	end
end

def day7_image(job)
	list = LinkedList.new('nil',0)
	params[:labels7] = Array.new
	params[:data7] = Array.new
	job.each do |j|
		if j.job.ip_map_id.blank?	
			list.add('Unknown IP',1)
		else			
			if j.job.ip_map.campus_buildings_list.blank?
				list.add('Unknown IP',1)
			else
				list.add(j.job.ip_map.campus_buildings_list.building_name,1)
			end	
		end	
	end	
	current = list.re_list 
	
	if current.next_node.nil?
		return 0
	else
		while current.next_node != nil
			current = current.next_node
			params[:labels7]<<current.name.to_s
			params[:data7]<<current.value
		end
		return 1
	end	
end

#######

def show_vplace(threat_id,d1,d2)
  # return "skip"
  html_string = ""
  now=Time.now.to_f
  #
  @victim_inner = JobLog.find(
                      :all,
                      :select => 'victim_ip ,SUM(1) total',
                      :group => 'victim_ip',
                      :conditions => ["threat_id=? and victim_ip  REGEXP '^140.113' and log_time between ? and ?",threat_id,d1,d2],
                      :order => 'total DESC',
                      :limit => 3)
  @victim_outer = JobLog.find(
                      :all,
                      :select => 'victim_ip ,country,SUM(1) total',
                      :group => 'victim_ip',
                      :conditions => ["threat_id=? and victim_ip NOT REGEXP '^140.113' and log_time between ? and ?",threat_id,d1,d2],
                      :order => 'total DESC',
                      :limit => 3)   
  sum = 0
  @victim_inner.each do |r|
    sum = sum + r.total
  end                    
                                       
  @victim_inner.each do |r|
    em =  IpMap.where("ip=?",r.victim_ip).first 
    percent = 100.0*(r.total)/sum
    if not em.blank?
        build_map=CampusBuildingsList.find(em.campus_buildings_list_id)
        if not build_map.blank?
          html_string +="<p>("+r.victim_ip+")"+build_map.building_name.to_s+" "+number_with_precision(percent, :precision => 1).to_s+"%</p>"
        else
           html_string +="<p>("+r.victim_ip+") "+number_with_precision(percent, :precision => 1).to_s+"%</p>"
        end
    else
          html_string +="<p>("+r.victim_ip+") "+number_with_precision(percent, :precision => 1).to_s+"%</p>"
    end
  end
  html_string +="<p>--------------------------</p>"
  sum = 0 
  @victim_outer.each do |r|
    sum = sum + r.total
  end
  @victim_outer.each do |r|
    em =  IpMap.where("ip=?",r.victim_ip).first 
    percent = 100.0*(r.total)/sum
    if not em.blank?
        build_map=CampusBuildingsList.find(em.campus_buildings_list_id)
        if not build_map.blank?
          html_string +="<p>("+r.victim_ip+")"+build_map.building_name.to_s+" "+number_with_precision(percent, :precision => 1).to_s+"% "
          html_string +=(r.country || "")+"</p>"
        else
          html_string +="<p>("+r.victim_ip+") "+number_with_precision(percent, :precision => 1).to_s+"% "+(r.country || "")+"</p>"
        end
    else
          html_string +="<p>("+r.victim_ip+") "+number_with_precision(percent, :precision => 1).to_s+"% "+(r.country || "")+"</p>"
		  
    end
  end
  x=Time.now.to_f-now
  #html_string+="<p>TIME1:"+x.to_s+"</p>"
  return html_string.html_safe
end
def show_splace(threat_id,d1,d2,totalsession)
 # return "skip"
  html_string = ""

  now=Time.now.to_f
  @source=ActiveRecord::Base.connection.execute("
	SELECT src_ip, SUM( log_count ) total
	FROM job_details
	WHERE job_id
	IN (
		SELECT job_id
		FROM job_logs
		WHERE threat_id ='#{threat_id}' AND log_time BETWEEN '#{d1}' AND '#{d2}'
	)
	GROUP BY src_ip
	ORDER by total DESC
	")                  #temp_table2
  
  @source.each_with_index do |r , i|
	break if i == 5
    em =  IpMap.where("ip=?",r[0]).first 
    percent  = 100*(r[1])/totalsession.to_i
    if not em.blank?
        build_map=CampusBuildingsList.find(em.campus_buildings_list_id)
        if not build_map.blank?
          html_string +="<p>("+r[0]+")"+build_map.building_name.to_s+" "+number_with_precision(percent, :precision => 1).to_s+"%</p>"
        else
           html_string +="<p>("+r[0]+") "+number_with_precision(percent, :precision => 1).to_s+"%</p>"
        end
    else
          html_string +="<p>("+r[0]+") "+number_with_precision(percent, :precision => 1).to_s+"%</p>"
    end
  end
  
  x=Time.now.to_f-now
  #html_string+="<p>TIME2:"+x.to_s+"</p>"
  
  return html_string.html_safe
end


def number_to_weekday(num)
  if num==1
    "Sunday"
  elsif num==2  
    "Monday"
  elsif num==3
    "Tuesday" 
  elsif num==4
    "Wednsday" 
  elsif num==5
    "Thursday" 
  elsif num==6
    "Friday" 
  elsif num==7
    "Saturday" 
  else
    "ERROR"  
  end
end

def number_to_month(num)
  if num==1
    "January"
  elsif num==2  
    "February"
  elsif num==3
    "March" 
  elsif num==4
    "April" 
  elsif num==5
    "May" 
  elsif num==6
    "June" 
  elsif num==7
    "July" 
  elsif num==8
    "Auguest"
  elsif num==9
    "September"
  elsif num==10
    "October"
  elsif num==11
    "November"
  elsif num==12
    "December"          
  else
    "ERROR"  
  end
end

def inside_session(threat_id,d1,d2)
  html_string=""
  now=Time.now.to_f
  #@source=ActiveRecord::Base.connection.execute("SELECT count(job_id) FROM temp_table2 WHERE threat_id='#{threat_id}'")
  #return @source.first[0]
  html_string+=JobLog.where("threat_id=? and log_time BETWEEN ? AND ?",threat_id,d1,d2).count.to_s
  x=Time.now.to_f-now
  
  #html_string+="<p>TIME:"+x.to_s+"</p>"
  return html_string.html_safe
  
end
def outside_session(threat_id,d1,d2)

  html_string=""
  now=Time.now.to_f
  html_string+=OutsideLog.where("threat_id=? and log_time BETWEEN ? AND ?",threat_id,d1,d2).count.to_s
  
  x=Time.now.to_f-now
  #html_string+="<p>TIME:"+x.to_s+"</p>"
  
  return html_string.html_safe
end 


def outside_splace(threat_id,d1,d2,totalsession)	         
  html_string = ""
  if totalsession != 0 
	  now=Time.now.to_f
	  @source=ActiveRecord::Base.connection.execute("
		SELECT src_ip , country , SUM(sum) total
		FROM outside_counts
		WHERE id
		IN (
			SELECT outside_counts_id
			FROM outside_logs
			WHERE threat_id ='#{threat_id}' AND log_time BETWEEN '#{d1}' AND '#{d2}'
		)
		GROUP BY src_ip
		ORDER by total DESC
		") 

	   @source.each_with_index do |r , i|
		break if i == 5
		percent  = 100*(r[2]).to_i/totalsession.to_i  
		html_string +="<p>"+r[0]+"("+(r[1]||"")+") "+number_with_precision(percent, :precision => 1).to_s+"%</p>\n"
	   end
	  
	  x=Time.now.to_f-now
	  #html_string+="<p>TIME:"+x.to_s+"</p>"
  end
  
  
  return html_string.html_safe
end




def outside_vplace(threat_id,d1,d2,totalsession)
  html_string = ""
  if totalsession!=0
	  now=Time.now.to_f
	  @victim = OutsideLog.find(
			:all,
			:select => 'victim_ip ,SUM(1) total',
			:group => 'victim_ip',
			:conditions => ["threat_id=? and log_time between ? and ? ",threat_id,d1,d2],
			:order => 'total DESC',
			:limit => 5)
	 
	    
	 
	 @victim.each do |r| 
		percent  = 100*(r.total)/totalsession.to_i
		em =  IpMap.where("ip=?",r.victim_ip).first 
		if not em.blank?
			build_map=CampusBuildingsList.find(em.campus_buildings_list_id)
			if not build_map.blank?
			  html_string +="<p>("+r.victim_ip+")"+build_map.building_name.to_s+" "+number_with_precision(percent, :precision => 1).to_s+"%</p>"
			else
			  html_string +="<p>("+r.victim_ip+") "+number_with_precision(percent, :precision => 1).to_s+"%</p>"
			end
		else
			  html_string +="<p>("+r.victim_ip+") "+number_with_precision(percent, :precision => 1).to_s+"%</p>"
		end
	  end
	  
	  x=Time.now.to_f-now
	  #html_string+="<p>TIME:"+x.to_s+"</p>"
  end
  return html_string.html_safe  
end

def diff_7day(d1,d2,res)
  html_string = ""
  tmp_d1 = d1.to_datetime
  tmp_count = 0
  res.each do |r|
    date = DateTime.strptime(r.d, "%m/%d/%Y").to_datetime
    if date >= tmp_d1.ago(1.day) and date <= tmp_d1.since(7.day)
      tmp_count = tmp_count + r.total.to_i
    else
      html_string = html_string +"['"+tmp_d1.strftime("%m/%d").to_s+"',"+tmp_count.to_s+"]," 
      tmp_count = r.total.to_i
      tmp_d1 = tmp_d1.since(7.day) 
      until (date>=tmp_d1.ago(1.day) and date<=tmp_d1.since(7.day)) or tmp_d1 > d2 do  
         html_string = html_string +"['"+tmp_d1.strftime("%m/%d").to_s+"',0]," 
         tmp_d1 = tmp_d1.since(7.day)    
      end      
    end
  end # do
  html_string = html_string +"['"+tmp_d1.strftime("%m/%d").to_s+"',"+tmp_count.to_s+"],"
  return html_string
end

def show_result(r,d1,d2,count)
	
	html = ""
	countt=count
	while countt <= count+1 do
	
		html << "<tr>\n"
		ser = JobThreat.find(:first,:conditions=>["threat_id=?",r[countt].threat_id])
		html<< "<td>\n"
		if not ser.blank? and not ser.serverity.blank? 
			html<< ser.serverity.to_s
		else
			html<< "\tNo Classified"
		end
		html<< "</td>\n"		
		em =  EventMap.find(:first,:conditions=>["thread_id=?",r[countt].threat_id])
		if not em.blank?
			if not em.name.blank?
				html<< "<td>"+em.name.to_s+"("+r[countt].threat_id.to_s+")</td>"
			else
				html<< "<td>("+r[countt].threat_id.to_s+")</td>"
			end
			if not em.threat_type.blank?
				html<< "<td>"+em.threat_type.to_s+"</td>"
			else
				html<< "<td>No Record</td>"	
			end
		else
			html<< "<td>Not Record Event Id("+r[countt].threat_id.to_s+")</td>"
			html<< "<td>No Record</td>"	
		end
		html<< "<td>"
		insidesession=inside_session(r[countt].threat_id,d1,d2)
		html<< '<div id="session_in_'+countt.to_s+'">'+insidesession+"</div>"
		outsidesession=outside_session(r[countt].threat_id,d1,d2)
		html<< '<div id="session_out_'+countt.to_s+'" style="display:none">'+outsidesession.to_s+"</div>"
		html<< "</td>"
		html<< "<td>"
		html<< '<div id="splace_in_'+countt.to_s+'">'+show_splace(r[countt].threat_id,d1,d2,insidesession)+"</div>"
		html<< '<div id="splace_out_'+countt.to_s+'" style="display:none">'+outside_splace(r[countt].threat_id,d1,d2,outsidesession)+"</div>"
		html<< "</td>"
		html<< "<td>"
		html<< '<div id="vplace_in_'+countt.to_s+'">'+show_vplace(r[countt].threat_id,d1,d2)+"</div>"
		html<< '<div id="vplace_out_'+countt.to_s+'" style="display:none">'+outside_vplace(r[countt].threat_id,@d1,@d2,outsidesession)+"</div>"
		html<< "</td>"
		html<< '<td><a href="/statistics/show_chart?d1='+d1.to_s+"&d2="+d2.to_s+"&threat_id="+r[countt].threat_id.to_s+'">分佈圖</td>"'
		html<< "</tr>"
		countt+=1
	end
	return html.html_safe
end

end
