class SignupsController < ApplicationController
  before_filter :user_signed_in?
  before_filter :find_account, only: [:edit, :update]
  layout 'landing'

  def new
    @signup = Signup.new
  end

  def create
    @signup = Signup.new(params[:signup])
    if @signup.save
      # binding.pry
      sign_in(:user, @signup.user)
      redirect_to backend_me_timelogs_path
    else
      render :new
    end
  end

  def edit

  end

  def update

  end


  private
  def user_signed_in?
    current_user.nil? ? true : redirect_to(backend_me_timelogs_path)
  end

  def find_account
    @account = Account.find(params[:id]) if params[:id]
  end
end
