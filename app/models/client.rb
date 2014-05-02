# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  account_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Client < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :account_id

  belongs_to :account
  has_many :projects
  has_many :parts, through: :projects
  has_many :timelogs, through: :parts

  include TimeFormattable

  def users
    User.includes(:timelogs).where("timelogs.id IN (?)", timelog_ids)
  end

  def time_worked_overall
    present_as_time(self.parts.inject(0) {|sum, part| sum += part.timelogs.sum(:duration)})
  end


end
