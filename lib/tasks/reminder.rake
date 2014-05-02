namespace :reminder do
  desc "Send reminder e-mail to users that didn't fill in their worklog today"
  task :run => :environment do
    User.users_to_remind.each do |u|
      UserMailer.today_logs_reminder(u).deliver
    end
  end
end