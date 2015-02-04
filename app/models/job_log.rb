class JobLog < ActiveRecord::Base
  attr_accessible :job_id, :log_time, :victim_ip, :threat_id, :action, :country, :threat_type
  belongs_to :job
  has_one :job_detail
 # belongs_to :job_detail
  def self.log_time_between(d1,d2)
	where("log_time between ? and ?",d1,d2)
  end

  def self.temp(d1,d2)
    
    ActiveRecord::Base.connection.execute("DROP TEMPORARY TABLE IF EXISTS temp_table")
    
    ActiveRecord::Base.connection.execute("CREATE TEMPORARY TABLE temp_table SELECT threat_id FROM job_logs WHERE log_time between '#{d1}' and '#{d2}'")
    #ActiveRecord::Base.connection.execute("INSERT INTO temp_table SELECT threat_id FROM outside_logs WHERE log_time between '#{d1}' and '#{d2}'")
    
    @res =  ActiveRecord::Base.connection.execute("SELECT threat_id,count(*) total FROM temp_table GROUP BY threat_id ORDER BY total DESC LIMIT 10")
    
  ensure
    ActiveRecord::Base.connection.execute("DROP TEMPORARY TABLE IF EXISTS temp_table")
    
    return @res
  end
  
  def self.temp2(d1,d2)
    
    ActiveRecord::Base.connection.execute("DROP TEMPORARY TABLE IF EXISTS temp_table2")   
    ActiveRecord::Base.connection.execute("CREATE TEMPORARY TABLE temp_table2 SELECT threat_id,job_id,victim_ip FROM job_logs WHERE log_time between '#{d1}' and '#{d2}'")
    ActiveRecord::Base.connection.execute("CREATE INDEX index_threat_id ON temp_table2 (threat_id)")
	  ActiveRecord::Base.connection.execute("CREATE INDEX index_job_id ON temp_table2 (job_id)")
  end
    
		
	def self.new_from_splunk(jd_id, row)
		jl = nil
		if row["Serverity"] != 'informational' and row["Action"] != 'alert'
			threat_id = grep_threat_id(row["Threat/Content Name"])
			jl = self.new
			jl.job_id, jl.log_time = jd_id, row["Time Logged"]
			jl.victim_ip, jl.threat_id = row["Destination address"], threat_id
			jl.action, jl.country, jl.threat_type = row["Action"], row["Destination Country"], row["Threat/Content Type"]
			jl.save!
			
			JobThreat.new_from_splunk(job_id, threat_id, row["Serverity"])
			
		end
		return jl
	end
	
private

	def grep_threat_id(str)
		str = str.split('') 
		start = str.length-1
		(str.length-1).downto(0) do |i|
			break if str[i]=='('
			start = i	
		end
		p str[start..-2].join('')
	end
	
end
