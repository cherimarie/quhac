require 'rails_helper'

RSpec.describe ProvidersController, type: :controller do
  before do
    clinic1 = Clinic.create(
      name: 'Jungle Clinic',
      street_address: '123 Pine St',
      city: 'Seattle',
      zip: '98122',
      phone: '206-206-1206'
    )
    @clinic2 = Clinic.create(
      name: 'Savannah Clinic',
      street_address: '123 Spruce St',
      city: 'Woodinville',
      zip: '98199',
      phone: '206-206-1206'
    )

    @bull_pro = Provider.create(
      name: 'Dr. Torres',
      clinic_id: clinic1.id,
      specialization: 'diabetics, squids, pediatric oncology',
      type: 'phrenologist',
      email: nil,
      population_expertise: 'children',
      gender_id: 'male',
      orientation: nil,
      comprehensive_intake: nil,
      use_pref_name: nil,
      trans_standard_of_care: nil,
      gender_neutral_rr: true,
      lgbtq_trained: nil,
      lgbtq_training_details: nil,
      cultural_trained: false,
      cultural_training_details: nil,
      lgbq_incl_strategy: nil,
      trans_incl_strategy: 'Listen to people\'s choices and identities',
      new_clients: true,
      community_relationship: nil,
      additional: 'Donate to Camp Ten Trees every year'
    )
    @monkey_pro = Provider.create(
      name: 'Dr. Monkey',
      clinic_id: clinic1.id,
      specialization: 'trans-men, athletes',
      type: 'dermatologist',
      email: nil,
      population_expertise: nil,
      gender_id: 'female',
      orientation: 'straight',
      comprehensive_intake: nil,
      use_pref_name: nil,
      trans_standard_of_care: nil,
      gender_neutral_rr: false,
      lgbtq_trained: true,
      lgbtq_training_details: 'Edna, in accounting, said to be cool',
      cultural_trained: true,
      cultural_training_details: 'We read a lot',
      lgbq_incl_strategy: nil,
      trans_incl_strategy: nil,
      new_clients: false,
      community_relationship: nil,
      additional: 'I want to hug everyone'
    )

    @trek_pro = Provider.create(
      name: 'Dr. McCoy',
      clinic_id: @clinic2.id,
      specialization: 'trans-men, diabetics, athletes',
      type: '',
      email: nil,
      population_expertise: 'Vulcans, Worf',
      gender_id: nil,
      orientation: 'it\'s complicated',
      comprehensive_intake: true,
      use_pref_name: true,
      trans_standard_of_care: nil,
      gender_neutral_rr: nil,
      lgbtq_trained: false,
      lgbtq_training_details: 'Workshop from Bob Ross',
      cultural_trained: nil,
      cultural_training_details: 'Workshop by Bobby Blass',
      lgbq_incl_strategy: nil,
      trans_incl_strategy: nil,
      new_clients: nil,
      community_relationship: 'Sponsor Gay City\'s softball team',
      additional: ''
    )
    @lion_pro = Provider.create(
      name: 'Dr. Lion',
      clinic_id: @clinic2.id,
      specialization: '',
      type: 'acupuncturist',
      email: 'rawr@example.com',
      population_expertise: 'children',
      gender_id: 'two spirit',
      orientation: 'gay',
      comprehensive_intake: false,
      use_pref_name: true,
      trans_standard_of_care: nil,
      gender_neutral_rr: nil,
      lgbtq_trained: nil,
      lgbtq_training_details: 'Cheryl Ingram taught workshop',
      cultural_trained: nil,
      cultural_training_details: nil,
      lgbq_incl_strategy: 'Respect for all clients',
      trans_incl_strategy: nil,
      new_clients: true,
      community_relationship: nil,
      additional: 'I like turtles'
    )

    care = Insurer.create(name: "Medicare", is_medicare: true)
    caid = Insurer.create(name: "Molina", is_medicaid: true)
    ProviderInsurer.create(provider_id: @bull_pro.id, insurer_id: caid.id)
    ProviderInsurer.create(provider_id: @monkey_pro.id, insurer_id: caid.id)
    ProviderInsurer.create(provider_id: @monkey_pro.id, insurer_id: care.id)
  end


  describe 'index' do
    it 'returns all providers' do
      get :index

      expect(assigns(:providers).length).to eq(4)
      expect(assigns(:providers)).to include(@trek_pro)
      expect(assigns(:providers)).to include(@bull_pro)
      expect(assigns(:providers)).to include(@lion_pro)
      expect(assigns(:providers)).to include(@monkey_pro)
    end
  end

  describe 'quick search on index' do
    it 'returns providers whose name matches query' do
      get :index, search: 'monkey'

      expect(assigns(:providers)).to eq([@monkey_pro])
    end

    it 'returns providers whose type matches query' do
      get :index, search: 'phrenologist'

      expect(assigns(:providers)).to eq([@bull_pro])
    end

    it 'returns providers whose specialization matches query' do
      get :index, search: 'trans-men'

      expect(assigns(:providers).length).to eq(2)
      expect(assigns(:providers)).to include(@monkey_pro)
      expect(assigns(:providers)).to include(@trek_pro)
    end

    it 'returns providers whose clinic name matches query' do
      get :index, search: 'Savannah'

      expect(assigns(:providers).length).to eq(2)
      expect(assigns(:clinics)).to eq([@clinic2])
      expect(assigns(:providers)).to include(@lion_pro)
      expect(assigns(:providers)).to include(@trek_pro)
    end
  end

  describe 'text search on index' do
    it 'searches name' do
      get :index, text_search: 'Lion'

      expect(assigns(:providers)).to eq([@lion_pro])
    end

    it 'searches email' do
      get :index, text_search: 'rawr@example.com'

      expect(assigns(:providers)).to eq([@lion_pro])
    end
    it 'searches type' do
      get :index, text_search: 'acupuncturist'

      expect(assigns(:providers)).to eq([@lion_pro])
    end
    it 'searches population_expertise' do
      get :index, text_search: 'Vulcans'

      expect(assigns(:providers)).to eq([@trek_pro])
    end
    it 'searches specialization' do
      get :index, text_search: 'pediatric oncology'

      expect(assigns(:providers)).to eq([@bull_pro])
    end
    it 'searches gender_id' do
      # is this a problem?
      get :index, text_search: 'male'

      expect(assigns(:providers)).to eq([@bull_pro, @monkey_pro])
    end
    it 'searches orientation' do
      get :index, text_search: 'straight'

      expect(assigns(:providers)).to eq([@monkey_pro])
    end
    it 'searches trans_standard_of_care' do
      # pending 'this is maybe not right'
      # get :index, text_search: 'wpath'

      # expect(assigns(:providers)).to eq([])
    end
    it 'searches lgbtq_training_details' do
      get :index, text_search: 'Cheryl Ingram'

      expect(assigns(:providers)).to eq([@lion_pro])
    end
    it 'searches cultural_training_details' do
      get :index, text_search: 'bobby'

      expect(assigns(:providers)).to eq([@trek_pro])
    end
    it 'searches lgbq_incl_strategy' do
      get :index, text_search: 'respect'

      expect(assigns(:providers)).to eq([@lion_pro])
    end
    it 'searches trans_incl_strategy' do
      get :index, text_search: 'identities'

      expect(assigns(:providers)).to eq([@bull_pro])
    end
    it 'searches community_relationship' do
      get :index, text_search: 'softball'

      expect(assigns(:providers)).to eq([@trek_pro])
    end
    it 'searches additional' do
      get :index, text_search: 'hug'

      expect(assigns(:providers)).to eq([@monkey_pro])
    end
  end

  describe 'filter search on index' do
    it 'new-clients' do
      get :index, filter_search: {'new-clients' => '1'}

      expect(assigns(:providers)).to eq([@bull_pro, @lion_pro])
    end
    it 'type' do
      get :index, filter_search: {type: 'acupuncturist'}

      expect(assigns(:providers).length).to eq(1)
      expect(assigns(:providers)).to include(@lion_pro)
    end
    it 'expertise' do
      get :index, filter_search: {expertise: 'Vulcans, Worf'}

      expect(assigns(:providers)).to eq([@trek_pro])
    end
    it 'specialization' do
      get :index, filter_search: {specialization: 'trans-men, athletes'}

      expect(assigns(:providers)).to eq([@monkey_pro])
    end
    it 'gender_id' do
      get :index, filter_search: {'gender-id' => 'two spirit'}

      expect(assigns(:providers)).to eq([@lion_pro])
    end
    it 'orientation' do
      get :index, filter_search: {orientation: 'straight'}

      expect(assigns(:providers)).to eq([@monkey_pro])
    end
    it 'pref-name' do
      get :index, filter_search: {'pref-name' =>'1'}

      expect(assigns(:providers)).to eq([@trek_pro, @lion_pro])
    end
    it 'gend-neut-rr' do
      get :index, filter_search: {'gend-neut-rr' => '1'}

      expect(assigns(:providers)).to eq([@bull_pro])
    end
    it 'comp-intake' do
      get :index, filter_search: {'comp-intake' => '1'}

      expect(assigns(:providers)).to eq([@trek_pro])
    end
    it 'lgbtq-trained' do
      get :index, filter_search: {'lgbtq-trained' => '1'}

      expect(assigns(:providers)).to eq([@monkey_pro])
    end
    it 'cultu-trained' do
      get :index, filter_search: {'cultu-trained' => '1'}

      expect(assigns(:providers)).to eq([@monkey_pro])
    end
    it 'cultu-trained & lgbtq-trained & specialization' do
      get :index, filter_search: {'cultu-trained' => '1', 'lgbtq-trained' => '1', specialization: 'trans-men, athletes' }

      expect(assigns(:providers)).to eq([@monkey_pro])
    end
    it 'returns multiple results' do
      get :index, filter_search: {'new-clients' => '1'}

      expect(assigns(:providers)).to eq([@bull_pro, @lion_pro])
    end
    it 'filters comprehensively' do
      get :index, filter_search: {'new-clients' => '1', 'gend-neut-rr' => '1'}

      expect(assigns(:providers)).to eq([@bull_pro])
    end
    it 'medicaid' do
      get :index, filter_search: {'medicaid' => '1'}

      expect(assigns(:providers)).to eq([@bull_pro, @monkey_pro])
    end
    it 'medicare' do
      get :index, filter_search: {'medicare' => '1'}

      expect(assigns(:providers)).to eq([@monkey_pro])
    end
    it 'medicaid & medicarre' do
      get :index, filter_search: {'medicaid' => '1', 'medicare' => '1'}

      expect(assigns(:providers)).to eq([@bull_pro, @monkey_pro])
    end
    it 'sorts by name' do
      get :index, filter_search: {'new-clients' => '1', 'sort-by' => 'name'}

      expect(assigns(:providers)).to eq([@lion_pro, @bull_pro])
    end
    it 'sorts by type' do
      get :index, filter_search: {'new-clients' => '1', 'sort-by' => 'type'}

      expect(assigns(:providers)).to eq([@lion_pro, @bull_pro])
    end
    it 'sorts by zip' do
      get :index, filter_search: {'new-clients' => '1', 'sort-by' => 'zip'}

      expect(assigns(:providers)).to eq([@bull_pro, @lion_pro])
    end
    it 'sorts by city' do
      get :index, filter_search: {'new-clients' => '1', 'sort-by' => 'city'}

      expect(assigns(:providers)).to eq([@bull_pro, @lion_pro])
    end
  end

  describe 'show' do
    it 'sets the provider correctly' do
      get :show, id: @trek_pro.id

      expect(assigns(:provider)).to eq(@trek_pro)
    end
  end
end
