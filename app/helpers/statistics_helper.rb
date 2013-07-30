module StatisticsHelper

def count_stage(jobs)
	
	s1_count=0
	
	jobs.each do |j|
		if j.job.stage1=='un'
			s1_count=s1_count+1
		end	
	end
	
	s1_count
		
end

end
