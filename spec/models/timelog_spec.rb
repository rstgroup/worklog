require 'spec_helper'

describe Timelog do

    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :duration }
    it { is_expected.to validate_presence_of :worked_on }
    it { is_expected.to validate_presence_of :full_part_name }
    it { is_expected.to validate_presence_of :part_id }
end