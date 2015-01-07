require 'spec_helper'

describe Account do

  context 'it validates presence of name' do
    it { is_expected.to validate_presence_of :name }
  end
end