# == Schema Information
#
# Table name: parts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :integer
#

class Part < ActiveRecord::Base
  attr_accessible :name, :project_id

  belongs_to :account
  belongs_to :project
  has_many :timelogs, dependent: :destroy
  has_one :autocomplete_part

  before_create :assign_to_account

  validates_presence_of :name

  include TimeFormattable

  def autocomplete_label
    "#{project.client.name} - #{project.name} - #{name}"
  end

  def autocomplete_value
    self.id
  end

  def time_worked
    present_as_time self.timelogs.sum(:duration)
  end

  private
  def assign_to_account
    self.account_id = project.client.account_id
  end
end
