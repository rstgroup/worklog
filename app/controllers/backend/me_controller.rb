class Backend::MeController < BackendController

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update_params(params[:user])
      sign_in(current_user, :bypass => true)
      redirect_to edit_backend_me_path
    else
      render :edit
    end
  end
end
