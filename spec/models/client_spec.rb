require 'spec_helper'

describe Client do

    it { is_expected.to validate_presence_of :name }
end