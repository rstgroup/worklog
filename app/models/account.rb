# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Account < ActiveRecord::Base
  attr_accessible :name, :users_attributes

  has_many :clients
  has_many :parts
  has_many :users, dependent: :destroy
  has_many :timelogs, through: :users
  has_many :autocomplete_parts
  validates :name, presence: true, allow_blank: false
 
end
 
