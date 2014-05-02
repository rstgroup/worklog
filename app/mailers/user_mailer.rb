# encoding: UTF-8

class UserMailer < ActionMailer::Base
  default from: "reminder@worklog.kmpgroup.pl"

  def today_logs_reminder(user)
    @user = user
    mail(:to => user.email, :subject => "O czymś nie zapomniałeś?")
  end
end
