require 'spec_helper'

describe Signup do

  context 'validates presence of company_name' do
    it { is_expected.to validate_presence_of :company_name }
  end

  context 'validates presence of email' do
    it { is_expected.to validate_presence_of :email }
  end

  context 'validates presence of password' do
    it { is_expected.to validate_presence_of :password }
  end

  describe '#save' do
    before { @signup = Signup.new }

    context 'when email is invalid' do
      it { is_expected.to be_falsy }
    end
  end

end