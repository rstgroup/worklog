require 'spec_helper'

describe Timelog do

  context 'validates presence of name' do
    it { is_expected.to validate_presence_of :name }
  end

  context 'validates presence of duration' do
    it { is_expected.to validate_presence_of :duration }
  end

  context 'validates presence of worked_on' do
    it { is_expected.to validate_presence_of :worked_on }
  end

  context 'validates presence of full_part_name' do
    it { is_expected.to validate_presence_of :full_part_name }
  end

  context 'validates presence of part_id' do
    it { is_expected.to validate_presence_of :part_id }
  end


end