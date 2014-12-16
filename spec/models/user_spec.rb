require 'spec_helper'

describe User do

  it { is_expected.to validate_presence_of :name }

  describe '#update_params' do
    let(:user) { create(:user) }
    subject { user.update_params(params) }

    context 'when params are valid' do
      let(:params) { {name: 'Foo Bar'} }

      it 'changes the name to Foo Bar' do
        expect{ subject }.to change(user, :name).to('Foo Bar')
      end

      it { is_expected.to be_truthy }
    end

    context 'when params are invalid' do
      let(:params) { {email: 'invalid_email'} }

      it { is_expected.to be_falsy }
    end
  end

  describe '#worked_today' do
    pending 'TODO'
  end

  describe "Email reminders" do
    it "receives a reminder when no timelogs were created that day" do
      Timecop.travel Date.parse "friday"
      @user = create(:user)
      expect(User.users_to_remind.size).to eq 1
      Timecop.return
    end

    it "receives reminder when no timelogs were created that day but had been created the day before and day after" do
      Timecop.travel Date.parse 'friday'
      @user = create(:user)
      create(:timelog, :user => @user, :worked_on => Date.yesterday)
      create(:timelog, :user => @user, :worked_on => Date.tomorrow)
      expect(User.users_to_remind.size).to eq 1
      Timecop.return
    end

    it "doesn't receive reminder when at least one timelog was created this day" do
      Timecop.travel Date.parse 'friday'
      @user = create(:user)
      create(:timelog, :user => @user, :worked_on => Date.today)
      expect(User.users_to_remind.size).to eq 0
      Timecop.return
    end

    it "doesn't receive reminder on saturnday and sunday" do
      Timecop.travel Date.parse "saturday"
      @user = create(:user)
      expect(User.users_to_remind.size).to eq 0
      Timecop.travel Date.parse "sunday"
      expect(User.users_to_remind.size).to eq 0
      Timecop.return
    end
  end
end
