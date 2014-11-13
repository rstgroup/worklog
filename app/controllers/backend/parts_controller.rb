class Backend::PartsController < BackendController
  respond_to :js, :html, :json

  before_filter :find_parents, :only => [:create]
  before_filter :find_part, :only => [:destroy, :update]

  def create
    @part = @project.parts.build params[:part]
    unless @part.save
      render :status => 406, :text => ""
    end
  end

  def update
    render :status => 406 unless @part.update_attributes(:name => params[:name])
  end

  def autocomplete
    @parts = current_user.account.autocomplete_parts.where('LOWER(calculated_name) LIKE LOWER(?)', "%#{params[:query]}%")
    render json: @parts, each_serializer: AutocompletePartSerializer, root: false
  end

  def destroy
    @part.destroy
    redirect_to backend_client_path(@part.project.client)
  end

  private
    def find_parents
      @client = current_user.account.clients.find(params[:client_id])
      @project = @client.projects.find(params[:project_id])
    end

    def find_part
      @part = Part.find(params[:id])
      if @part.project.client.account.id != current_user.account_id
        render head: :forbidden
        return false
      end
    end

end
