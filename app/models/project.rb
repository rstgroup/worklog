# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  client_id  :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Project < ActiveRecord::Base
  attr_accessible :name

  belongs_to :client
  has_many :parts

  validates_presence_of :name

  include TimeFormattable


  def name_with_client
    "#{client.name} - #{name}"
  end

  def time_worked
    present_as_time self.parts.inject(0) {|sum, part| sum += part.timelogs.sum('duration')}
  end
end
