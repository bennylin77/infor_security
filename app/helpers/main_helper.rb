module MainHelper
  
  def eventMapNameShowing(job)
    message=String.new
    job.job_threats.each do |t|      
      event=EventMap.find_by_thread_id(t.threat_id)
      if !event.nil?   
        if !event.name.nil? 
          message=message+'('+t.threat_id.to_s+')'+event.name  
        else
          message=message+'('+t.threat_id.to_s+')'+'--'    
        end 
        if !event.chinese_name.nil? 
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
  
  def eventMapDescriptionShowing(job)
    message=String.new
    job.job_threats.each do |t|          
      event=EventMap.find_by_thread_id(t.threat_id)
      if !event.nil?   
        if !event.description.nil? 
          message=message+'('+t.threat_id.to_s+')'+event.description
        else
          message=message+'('+t.threat_id.to_s+')'+'--'    
        end 
        if !event.chinese_description.nil? 
          message=message+'/'+event.chinese_description
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
  
  def eventMapSuggestionShowing(job)
    message=String.new
    job.job_threats.each do |t|       
      event=EventMap.find_by_thread_id(t.threat_id)
      if !event.nil?   
        if !event.suggestion.nil? 
          message=message+'('+t.threat_id.to_s+')'+event.suggestion
        else
          message=message+'('+t.threat_id.to_s+')'+'--'    
        end 
      else
        message=message+'('+t.threat_id.to_s+')'+'--'             
      end     
      message=message+'<br>'
    end     
    message
  end
  
  def threatIdShowing(job)
    message=String.new  
    job.job_threats.each do |t|            
      message=message+t.threat_id.to_s+'<br>'   
    end     
    message
  end
  
  
  def victimIpShowing(job_id=nil, always_visible=false)  
    if !always_visible
      job_logs=JobLog.find(:all, :conditions => [ "job_id = ?", job_id], :order=>"log_time DESC", :limit=>5)
      message=String.new
      job_logs.each do |j|
        message=message+j.victim_ip+' @ '+j.log_time.in_time_zone('UTC').to_formatted_s(:short)+'<br>'
      end
      message+'...'
    else
      job_logs=JobLog.find(:all, :conditions => [ "job_id = ?", job_id], :order=>"log_time DESC")
      message=String.new
      job_logs.each do |j|
        message=message+'('+j.threat_id.to_s+')'+j.victim_ip+' @ '+j.log_time.in_time_zone('UTC').to_formatted_s(:short)+'<br>'
      end
      message
    end                
  end
  
  def serverityShowing(job)
    message=String.new  
    job.job_threats.each do |t|            
      message=message+'('+t.threat_id.to_s+')'+t.serverity.to_s+'<br>'   
    end     
    message  
  end
   
  def setConditionColor(con)
    if con=="finish"
      "green.png"
    elsif con=="processing"
      "yellow.png"     
    elsif con=="un"
      "red.png"
    elsif con=="returned"
      "blueimportantsign.png"
    end    
  end
  
  def updateDays(job)
	time = (job.job_detail.updated_at - job.job_detail.created_at)/60/60/24
	if time >3.0
		time = image_tag("red_d.png", :size => "10x10")
	elsif time >2.0
		time = image_tag("yellow_d.png", :size => "10x10")
	elsif time >1.0
		time = image_tag("green_d.png", :size => "10x10")
	else
		time = ''
	end
	time
  end
end
