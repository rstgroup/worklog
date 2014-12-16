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
    it "creates a PartialLog with proper last_resume_at" do
      expect(@partial_log.last_resume_at).to  be_within(1).of(Time.now)
      expect(@partial_log.duration).to eq 0
    end
  end

  context "Pausing Timer" do
    it "updates the duration after" do
      time_travel_to 2.hours.from_now
      @partial_log.pause!
      expect(@partial_log.duration).to eq 120
    end
  end

  context "Resuming Timer" do
    it "updates the value of last_resume_at" do
      time_travel_to 2.hours.from_now
      @partial_log.pause!
      time_travel_to 1.hour.from_now
      @partial_log.resume!
      expect(@partial_log.last_resume_at).to be_within(1).of(Time.now)
    end
  end

  context "Resuming and Pausing Timer" do
    it "calculates the complete duration" do
      time_travel_to 2.hours.from_now
      @partial_log.pause!
      expect(@partial_log.duration).to eq 120
      time_travel_to 1.hour.from_now
      @partial_log.resume!
      time_travel_to 1.hour.from_now
      @partial_log.pause!
      expect(@partial_log.duration).to eq 180
    end
  end

  context "Stopping Timer" do
    it "updates the duration and move the timer to the finished state" do
      time_travel_to 2.hours.from_now
      @partial_log.pause!
      expect(@partial_log.duration).to eq 120
      time_travel_to 1.hour.from_now
      @partial_log.resume!
      time_travel_to 1.hour.from_now
      @partial_log.stop!
      expect(@partial_log.duration).to eq 180
      expect(@partial_log.finished?).to be_truthy
    end
  end
end
