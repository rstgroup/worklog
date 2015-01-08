require 'spec_helper'

describe Signup do

  it { is_expected.to validate_presence_of :company_name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to allow_value('foo@bar.pl').for(:email) }
  it { is_expected.to_not allow_value('foobar.pl').for(:email) }
  it { is_expected.to validate_presence_of :password }

  describe '#save' do
    let(:signup) { Signup.new(params) }
    subject { signup.save }

    context 'when params are invalid' do
      let(:params) {{ email: 'invalid', company_name: 'Foobars', password: 'foobar' }}

      it { is_expected.to be_falsy }

      it 'does not create a new Account' do
        expect{ subject }.not_to change(Account, :count)
      end

      it 'does not create a new User' do
        expect{ subject }.not_to change(User, :count)
      end

    end

    context 'when params are valid' do
      let(:params) { { email: 'foo@bar.pl', company_name: 'Foobar', password: 'foobar' } }

      it { is_expected.to be_truthy }

      it 'creates a new Account' do
        expect{ subject }.to change(Account, :count).by(1)
      end

      it 'creates a new User' do
        expect{ subject }.to change(User, :count).by(1)
      end

      it 'calls create! on the Account with proper params' do
        expect(Account).to receive(:create!)
          .with(
            hash_including name: params[:company_name]
          ).and_call_original
        subject
      end

      it 'creates a new User for the Account' do
        expect(User).to receive(:create!).with(
          hash_including email: params[:email],
            account_id: kind_of(Numeric)
        ).and_call_original
        subject
      end
    end
  end

end