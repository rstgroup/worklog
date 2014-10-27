class Signup
  include Virtus
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :account
  attr_accessor :user

  attribute :company_name, String
  attribute :email, String
  attribute :password, String

  validates :company_name, presence: true, allow_blank: false
  validates :email, presence: true, allow_blank: false, format: /\A[^@]+@[^@]+\z/
  validates :password, presence: true, allow_blank: false, length: {within: 6..128}

  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private
  def persist!
    Account.transaction do
      @account = Account.create!(name: company_name)
      @user = @account.users.create!(name: email, email: email, password: password, password_confirmation: password)
    end
  end

end