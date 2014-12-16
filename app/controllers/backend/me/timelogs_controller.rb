class Backend::Me::TimelogsController < BackendController

  def index
    @tl = current_user.timelogs.build
    find_timelogs
  end

  def create
    @tl = current_user.timelogs.build params[:timelog]
    @tl.account_id = current_user.account_id
    if @tl.save
      redirect_to backend_me_timelogs_path
    else
      find_timelogs
      render :index
    end
  end

  def destroy
    @timelog = current_user.timelogs.find params[:id]
    if @timelog && @timelog.delete
      redirect_to backend_me_timelogs_path
    else
      redirect_to backend_me_timelogs_path
    end
  end

  private
    def find_timelogs
      @timelogs = current_user.timelogs.paginate(per_page: 10, page: params[:page]).decorate
    end
end
