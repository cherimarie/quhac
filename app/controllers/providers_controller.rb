class ProvidersController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:search]
      @providers = Provider.search(params[:search])
      @clinics = Clinic.search(params[:search])
      @providers += Provider.where(clinic: @clinics)
      @showing_results = true
    else
      @providers = Provider.all
    end
  end

  def show
    @provider = Provider.find_by(id: params[:id])
  end

  private
  def provider_params
    params.require(:provider).permit(:name, :clinic_id)
  end
end
