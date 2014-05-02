class Backend::TimelogsController < BackendController

  def index
    if params[:sort]
      @timelogs = current_user.account.timelogs.where(user_id: params[:sort][:user_id]).paginate(per_page: 20, page: params[:page]).decorate
    else
      @timelogs = current_user.account.timelogs.paginate(per_page: 20, page: params[:page]).decorate
    end
  end

end
