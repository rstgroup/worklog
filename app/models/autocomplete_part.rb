# == Schema Information
#
# Table name: autocomplete_parts
#
#  calculated_name :text
#  part_id         :integer          default(0), not null
#  account_id      :integer
#

class AutocompletePart < ActiveRecord::Base
  belongs_to :account
  belongs_to :part
  default_scope order('calculated_name ASC')
end 
