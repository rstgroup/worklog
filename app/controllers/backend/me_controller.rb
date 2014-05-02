class Backend::MeController < BackendController
  
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if params[:user][:password].blank?
      params[:user].delete :password
    else
      params[:user][:password_confirmation] = params[:user][:password]
    end

    if @user.update_attributes params[:user]
      sign_in(@user, :bypass => true)
      redirect_to edit_backend_me_path
    else
      render :edit
    end
  end
end