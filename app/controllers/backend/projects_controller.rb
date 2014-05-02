class Backend::ProjectsController < BackendController
  respond_to :js, :html

  before_filter :find_client, :except => :update
  before_filter :find_project, :only => [:destroy, :update]


  def create
    @project = @client.projects.build params[:project]
    if @project.save
      @part = Part.new
    else
      render :status => 406, :text => ""
    end
  end

  def update
    render :status => 406 unless @project.update_attributes(:name => params[:name])
  end

  def destroy
    @project.destroy
    redirect_to backend_client_path(@project.client)
  end

  private
    def find_client
      @client = current_user.account.clients.find(params[:client_id])
    end

    def find_project
      @project = Project.find(params[:id])
      if @project.client.account.id != current_user.account_id
        render :status => :forbidden
        return false
      end
    end
end

