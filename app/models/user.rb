# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  name                   :string(255)
#  account_id             :integer          default(0), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  authentication_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invitation_token       :string(60)
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  theme                  :string(255)      default("cerulean")
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :theme, :company_name
  # attr_accessible :title, :body
  validates :name, presence: true, allow_blank: false, length: {within: 5..255}
  belongs_to :account
  has_many :timelogs
  has_many :partial_timelogs

  include TimeFormattable

  class << self
    def users_to_remind
      if Date.today.sunday? or Date.today.saturday?
        []
      else
        User.where("(select count(*) from timelogs where timelogs.worked_on = ? AND user_id=users.id) = 0", Date.today)
      end
    end
  end

  def worked_today
    timelogs.worked_today
  end

  def worked_today_percent
    percent = ((worked_today.to_f / 480.0) * 100).to_i
    percent > 100 ? 100 : percent
  end

  def time_worked_today
    present_as_time worked_today
  end

  def time_worked_week
    present_as_time timelogs.worked_this_week
  end

  def time_worked_month
    present_as_time timelogs.worked_this_month
  end

  def time_worked_general_for_client client
    present_as_time client.timelogs.where("timelogs.id IN (?)", timelog_ids).worked_general
  end

  def theme
    attributes['theme'].blank? ? "cerulean" : attributes['theme']
  end

end
