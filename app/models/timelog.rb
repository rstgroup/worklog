# == Schema Information
#
# Table name: timelogs
#
#  id        :integer          not null, primary key
#  part_id   :integer
#  user_id   :integer
#  name      :text
#  duration  :integer
#  worked_on :date
#

class Timelog < ActiveRecord::Base
  attr_accessor :full_part_name, :account_id, :clock_duration
  attr_accessible :name, :duration, :worked_on, :full_part_name, :clock_duration
  default_scope order('worked_on DESC, user_id DESC')

  validates :name, presence: true, allow_blank: false, length: {within: 3..255}
  validates :duration, presence: true, numericality: true
  validates :clock_duration, presence: true, allow_blank: false, :if => Proc.new {|tl| tl.clock_duration.present?}
  validates :worked_on, presence: true
  validates :full_part_name, presence: true, allow_blank: false, :if => Proc.new {|tl| tl.part_id.blank?}
  validates :part_id, presence: true, numericality: true

  belongs_to :user
  belongs_to :part

  before_validation :set_part_id, on: :create, :if => Proc.new {|tl| tl.part_id.blank?}
  before_validation :parse_duration, :if => Proc.new {|tl| tl.clock_duration.present?}

  include TimeFormattable

  def self.worked_today
    where(worked_on: Date.today).sum(:duration)
  end

  def self.worked_general
    sum(:duration)
  end

  def self.worked_this_week
    where(worked_on: Time.now.beginning_of_week..Time.now.end_of_week).sum(:duration)
  end

  def self.worked_this_month
    where(worked_on: Time.now.beginning_of_month..Time.now.end_of_month).sum(:duration)
  end

  def human_duration
    present_as_time self.duration
  end

  private
  def parse_duration
    a = self.clock_duration.split(':')
    self.duration = a[0].to_i * 60
    self.duration += a[1].to_i
    if self.duration == 0 or self.duration < 0
      errors.add(:clock_duration, :too_small)
    end
  end

  def set_part_id
    ap = AutocompletePart.where(calculated_name: self.full_part_name, account_id: self.account_id).first
    if ap
      self.part_id = ap.part_id
    else
      errors.add(:full_part_name, :invalid)
    end
  end

end
