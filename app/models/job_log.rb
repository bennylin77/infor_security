class JobLog < ActiveRecord::Base
  attr_accessible :job_id, :log_time, :victim_ip, :threat_id, :action, :country, :threat_type
  belongs_to :job
  
  
  def self.temp(d1,d2)
    
    ActiveRecord::Base.connection.execute("DROP TEMPORARY TABLE IF EXISTS temp_table")
    
    ActiveRecord::Base.connection.execute("CREATE TEMPORARY TABLE temp_table SELECT threat_id FROM job_logs WHERE log_time between '#{d1}' and '#{d2}'")
    ActiveRecord::Base.connection.execute("INSERT INTO temp_table SELECT threat_id FROM outside_logs WHERE log_time between '#{d1}' and '#{d2}'")
    
    @res =  ActiveRecord::Base.connection.execute("SELECT threat_id,count(*) total FROM temp_table GROUP BY threat_id ORDER BY total DESC LIMIT 10")
    
  ensure
    ActiveRecord::Base.connection.execute("DROP TEMPORARY TABLE IF EXISTS temp_table")
    
    return @res
  end
    
  
end
