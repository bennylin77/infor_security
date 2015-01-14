# encoding: utf-8
namespace :Mail do

desc "daily statistics mailer"
	task :daily_statistics_send => :environment do # load rails environment before doing 
		users = AdmUser.all.select{|user| (user.mail_config and user.mail_config.weekly_statistic==1)}
		emails = users.map{|user| user.email }
		p emails.join(', ')
		#SystemMailer.dailyStatistics("u9510606@gmail.com").deliver
	end

end
