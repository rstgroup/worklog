class Backend::ClientsController < BackendController
  respond_to :js, :html

  before_filter :find_clients, :only =>:index
  before_filter :find_client, :only => [:destroy, :update, :show]

  def index
    initialize_forms
  end

  def update
    render :status => 406 unless @client.update_attributes(:name => params[:name])
  end

  def create
    @client = current_user.account.clients.build params[:client]
    if @client.save
      find_clients
      initialize_forms
    else
      render :status => 406, :text => ""
    end
  end

  def show
    @project = Project.new
    @part = Part.new
    if params[:sort]
      @timelogs = @client.timelogs.where(user_id: params[:sort][:user_id]).paginate(per_page: 20, page: params[:page]).decorate
    else
      @timelogs = @client.timelogs.paginate(per_page: 20, page: params[:page]).decorate
    end
  end

  def destroy
    @client.destroy
    redirect_to backend_clients_path
  end

  private
    def initialize_forms
      @client = Client.new
      @project = Project.new
      @part = Part.new
    end

    def find_clients
      @clients = current_user.account.clients.reload.decorate
    end

    def find_client
      @client = current_user.account.clients.find(params[:id]).decorate
    end
end

