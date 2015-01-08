require 'spec_helper'

describe Account do

    it { is_expected.to validate_presence_of :name }
end