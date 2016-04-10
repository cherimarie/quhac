class ProvidersController < ApplicationController
  load_and_authorize_resource

  def index
    # REVIEW: if these all have diff kinds of params, could we just put them all in index?
    # have the else block be "if no params?"
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
    @providers = Provider.text_search(params[:text_search])
    @showing_results = true
  end

  def filter_search

  end

  def provider_params
    params.require(:provider).permit(:name, :clinic_id)
  end
end
