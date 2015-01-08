require 'spec_helper'

describe Part do

    it { is_expected.to validate_presence_of :name }
end