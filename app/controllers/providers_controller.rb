class ProvidersController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:search]
      quick_search
    elsif params[:text_search]
      text_search
    elsif params[:filter_search]
      filter_search
    else
      @providers = Provider.all
    end
  end

  def show
    @provider = Provider.find_by(id: params[:id])
  end

  private
  def quick_search
    @providers = Provider.search(params[:search])
    @clinics = Clinic.search(params[:search])
    @providers += Provider.where(clinic: @clinics)
    @showing_results = true
  end

  def text_search

  end

  def filter_search

  end

  def provider_params
    params.require(:provider).permit(:name, :clinic_id)
  end
end
