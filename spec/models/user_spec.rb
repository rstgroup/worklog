# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  name                   :string(255)
#  account_id             :integer          default(0), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  authentication_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invitation_token       :string(60)
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  theme                  :string(255)      default("cerulean")
#

require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  context "Email reminders" do
    it "should receive reminder when no timelogs were created that day" do
      Timecop.travel Date.parse "friday"
      @user = FactoryGirl.create(:user)
      User.users_to_remind.size.should == 1
      Timecop.return
    end

    it "should receive reminder when no timelogs were created that day but had been created the day before and day after" do
      Timecop.travel Date.parse 'friday'
      @user = FactoryGirl.create(:user)
      FactoryGirl.create(:timelog, :user => @user, :worked_on => Date.yesterday)
      FactoryGirl.create(:timelog, :user => @user, :worked_on => Date.tomorrow)
      User.users_to_remind.size.should == 1
      Timecop.return
    end

    it "should not receive reminder when at least one timelog was created this day" do
      Timecop.travel Date.parse 'friday'
      @user = FactoryGirl.create(:user)
      FactoryGirl.create(:timelog, :user => @user, :worked_on => Date.today)
      User.users_to_remind.size.should == 0
      Timecop.return
    end

    it "should not receive reminder on saturnday and sunday" do
      Timecop.travel Date.parse "saturday"
      @user = FactoryGirl.create(:user)
      User.users_to_remind.size.should == 0
      Timecop.travel Date.parse "sunday"
      User.users_to_remind.size.should == 0
      Timecop.return
    end
  end
end
