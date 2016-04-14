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
      filter_search(params[:filter_search])
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
    # TODO remove dupes here
    @showing_results = true
  end

  def text_search
    @providers = Provider.text_search(params[:text_search])
    @showing_results = true
  end

  def filter_search(filters)
    @providers.where(nil)
    @providers = @providers.accepting_new_clients if filters['new-clients']
    @providers = @providers.type(filters[:type]) if filters[:type]
    @providers = @providers.expertise_includes(filters[:expertise]) if filters[:expertise]
    @providers = @providers.specialization(filters[:specialization]) if filters[:specialization]
    @providers = @providers.gender_id(filters[:gender_id]) if filters[:gender_id]
    @providers = @providers.orientation(filters[:orientation]) if filters[:orientation]
    @providers = @providers.use_pref_name if filters['pref-name']
    @providers = @providers.gender_neutral_rr if filters['gend-neut-rr']
    @providers = @providers.comprehensive_intake if filters['comp-intake']
    @providers = @providers.lgbtq_trained if filters['lgbtq-trained']
    @providers = @providers.cultural_trained if filters['cultu-trained']

    @showing_results = true
  end

  def provider_params
    params.require(:provider).permit(:name, :clinic_id)
  end
end
