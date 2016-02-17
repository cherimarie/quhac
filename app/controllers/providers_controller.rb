class ProvidersController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:search]
      @providers = Provider.search(params[:search])
    else
      @providers = Provider.all
    end
  end

  def show
    @provider = Provider.find_by(id: params[:id])
  end

  def edit
  end

  def update
  end

  private
  def provider_params
    params.require(:provider).permit(:name, :city)
  end
end
