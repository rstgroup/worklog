class Backend::UsersController < BackendController
  respond_to :js, :html

  before_filter :find_users, :only => :index
  before_filter :find_user, :only => [:edit, :update, :destroy]

  def index
    @user = User.new
  end

  def create
    if params[:user] && params[:user][:email] && !User.find_by_email(params[:user][:email])
      u = User.invite!(params[:user], current_user)
      u.account_id = current_user.account_id
      UserDecorator.decorate u
      u.save
    else
      render :status => 406, :text => ""
    end
  end

  def edit
    redirect_to backend_timelogs_path if @user.id != current_user.id
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete :password
    else
      params[:user][:password_confirmation] = params[:user][:password]
    end

    if @user.update_attributes params[:user]
      sign_in(@user, :bypass => true)
      redirect_to edit_backend_user_path(@user)
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
end
