# == Schema Information
#
# Table name: partial_timelogs
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  last_resume_at :datetime
#  duration       :integer
#  status         :string(255)      default("initialized")
#

require 'spec_helper'

describe PartialTimelog do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @partial_log = FactoryGirl.create(:partial_timelog, user: @user)
  end

  after(:each) do
    back_to_1985
  end

  context "Starting Timer" do
    it "should create a PartialLog with proper last_resume_at" do
      @partial_log.last_resume_at.should  be_within(1).of(Time.now)
      @partial_log.duration.should eq 0
    end
  end

  context "Pausing Timer" do
    it "should update the duration after" do
      time_travel_to 2.hours.from_now
      @partial_log.pause!
      @partial_log.duration.should eq 120
    end
  end

  context "Resuming Timer" do
    it "should update the value of last_resume_at" do
      time_travel_to 2.hours.from_now
      @partial_log.pause!
      time_travel_to 1.hour.from_now
      @partial_log.resume!
      @partial_log.last_resume_at.should be_within(1).of(Time.now)
    end
  end

  context "Resuming and Pausing Timer" do
    it "should calculate the complete duration" do
      time_travel_to 2.hours.from_now
      @partial_log.pause!
      @partial_log.duration.should eq 120
      time_travel_to 1.hour.from_now
      @partial_log.resume!
      time_travel_to 1.hour.from_now
      @partial_log.pause!
      @partial_log.duration.should eq 180
    end
  end

  context "Stopping Timer" do
    it "should update the duration and move the timer to the finished state" do
      time_travel_to 2.hours.from_now
      @partial_log.pause!
      @partial_log.duration.should eq 120
      time_travel_to 1.hour.from_now
      @partial_log.resume!
      time_travel_to 1.hour.from_now
      @partial_log.stop!
      @partial_log.duration.should eq 180
      @partial_log.finished?.should be_true
    end
  end
end
