class ProvidersController < ApplicationController
  load_and_authorize_resource

  def index
    @showing_results = true
    if params[:search]
      @providers = quick_search(params[:search])
    elsif params[:text_search]
      @providers = text_search(params[:text_search])
    elsif params[:filter_search]
      @providers = filter_search(params[:filter_search])
    else
      @providers = Provider.all
      @showing_results = false
    end
  end

  def show
    @provider = Provider.find_by(id: params[:id])
  end

  private
  def quick_search(quick_params)
    providers = Provider.search(quick_params)
    @clinics = Clinic.search(quick_params)
    providers += Provider.where(clinic: @clinics)
    return providers.uniq
  end

  def text_search(text_params)
    Provider.text_search(text_params)
  end

  def filter_search(filters)
    providers = Provider.where(nil) # Getting all Providers, so can be filtered
    providers = providers.accepting_new_clients if filters['new-clients']
    providers = providers.type(filters[:type]) if filters[:type].present?
    providers = providers.expertise_includes(filters[:expertise]) if filters[:expertise].present?
    providers = providers.specialization(filters[:specialization]) if filters[:specialization].present?
    providers = providers.gender_id(filters['gender-id']) if filters['gender-id'].present?
    providers = providers.orientation(filters[:orientation]) if filters[:orientation].present?
    providers = providers.use_pref_name if filters['pref-name']
    providers = providers.gender_neutral_rr if filters['gend-neut-rr']
    providers = providers.comprehensive_intake if filters['comp-intake']
    providers = providers.lgbtq_trained if filters['lgbtq-trained']
    providers = providers.cultural_trained if filters['cultu-trained']
    providers = providers.accepts_medicare if filters['medicare']
    providers = providers.accepts_medicaid if filters['medicaid']

    case filters['sort-by']
    when 'name', 'type'
      providers.order!(filters['sort-by'].to_sym)
    when 'zip', 'city'
      providers.includes(:clinic).order!("clinic.#{filters['sort-by']}")
    end
    return providers
  end

  def provider_params
    params.require(:provider).permit(:name, :clinic_id, :insurer_ids)
  end
end
