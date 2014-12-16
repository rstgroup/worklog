class Backend::UsersController < BackendController
  respond_to :js, :html

  before_filter :find_users, :only => :index
  before_filter :find_user, :only => [:edit, :update, :destroy]

  def index
    @user = User.new
  end

  def create
    if valid_invitation_params
      @user = User.invite!(params[:user], current_user)
      @user.account_id = current_user.account_id
      UserDecorator.decorate @user
      @user.save
      redirect_to backend_users_path
    else
      render 'create_failure'
    end
  end

  def edit
    redirect_to backend_timelogs_path if @user.id != current_user.id
  end

  def update
    @user = current_user
    User.my_update(params)
    if @user.update_attributes params[:user]
      sign_in(@user, :bypass => true)
      redirect_to edit_backend_me_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to backend_users_path
  end

  private
    def find_users
      @users = UserDecorator.decorate_collection current_user.account.users
    end

    def find_user
      @user = current_user.account.users.find(params[:id])
    end

    def valid_invitation_params
      return false unless params[:user]
      return false if User.find_by_email(params[:user][:email])
      @user = User.new(email: params[:user][:email])
      return false if !@user.valid? && @user.errors[:email].any? && @user.errors[:name].any?
      return true
    end
end
