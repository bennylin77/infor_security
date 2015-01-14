# encoding: utf-8
namespace :Mail do

desc "daily statistics mailer"
	task :daily_statistics_send => :environment do # load rails environment before doing 
		users = AdmUser.all.select{|user| (user.mail_config.weekly_statistic==true)}
		emails = users.map{|user| user.email }
		p emails.join(', ')
		SystemMailer.dailyStatistics(emails).deliver
	end

end
