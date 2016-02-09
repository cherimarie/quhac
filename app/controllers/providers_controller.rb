class ProvidersController < ApplicationController
  load_and_authorize_resource

  def index
    @providers = Provider.all
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
