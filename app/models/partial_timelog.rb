# == Schema Information
#
# Table name: partial_timelogs
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  last_resume_at :datetime
#  duration       :integer
#  status         :string(255)      default("initialized")
#

class PartialTimelog < ActiveRecord::Base
  include AASM

  attr_accessible :user_id, :last_resume_at, :duration
  belongs_to :user
  aasm_column :status

  aasm do
    state :initialized, initial: true
    state :running
    state :paused
    state :finished

    event :start, after: :set_last_resume_at do
      transitions from: :initialized, to: :running
    end

    event :pause, after: :calculate_duration do
      transitions from: :running, to: :paused
    end

    event :resume, after: :set_last_resume_at do
      transitions from: :paused, to: :running
    end

    event :stop, after: :calculate_duration do
      transitions from: [:running, :paused], to: :finished
    end
  end

  before_create lambda { |pt| pt.duration = 0 }
  before_create :start

  private
  def set_last_resume_at
    self.last_resume_at = Time.now
  end

  def calculate_duration
    self.duration += (Time.now - self.last_resume_at) / 60
    # TODO
  end
end
