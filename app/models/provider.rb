class Provider < ActiveRecord::Base
  validates :name, :clinic_id, presence: true
  validates_inclusion_of :icon, in: [nil, 'a', 'b', 'c']

  belongs_to :clinic
  delegate :street_address, :city, :zip, :phone, :website, to: :clinic

  has_many :provider_insurers, inverse_of: :provider
  has_many :insurers, through: :provider_insurers

  rails_admin do
    configure :provider_insurers do
      visible(false)
    end
  end

  self.inheritance_column = nil

  scope :accepting_new_clients, -> { where new_clients: true }
  scope :type, -> (type) { where type: type }
  scope :expertise_includes, -> (exp) { where population_expertise: exp }
  scope :specialization, -> (spec) { where specialization: spec }
  scope :gender_id, -> (gender) { where gender_id: gender }
  scope :orientation, -> (orientation) { where orientation: orientation }
  scope :use_pref_name, -> { where use_pref_name: true }
  scope :gender_neutral_rr, -> { where gender_neutral_rr: true }
  scope :comprehensive_intake, -> { where comprehensive_intake: true }
  scope :lgbtq_trained, -> { where lgbtq_trained: true }
  scope :cultural_trained, -> { where cultural_trained: true }

  # RailsAdmin uses this to show the dropdown of choices for icon attr
  def icon_enum
    [[nil], ['a'], ['b'], ['c']]
  end

  def self.search(search)
    search_length = search.split.length
    where([(['lower(name) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" }) +
    where([(['lower(type) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" }) +
    where([(['lower(specialization) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" })
  end

  def self.text_search(search)
    search_length = search.split.length

    where([(['lower(name) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" }) +
    where([(['lower(email) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" }) +
    where([(['lower(type) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" }) +
    where([(['lower(population_expertise) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" }) +
    where([(['lower(specialization) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" }) +
    where([(['lower(gender_id) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" }) +
    where([(['lower(orientation) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" }) +
    where([(['lower(trans_standard_of_care) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" }) +
    where([(['lower(lgbtq_training_details) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" }) +
    where([(['lower(cultural_training_details) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" }) +
    where([(['lower(lgbq_incl_strategy) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" }) +
    where([(['lower(trans_incl_strategy) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" }) +
    where([(['lower(community_relationship) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" }) +
    where([(['lower(additional) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" })
  end

  def accepts_medicaid
    ins = insurers.map{|i| i.name}
    medicaid = ['Molina', 'Coordinated Care', 'Amerigroup']

    return "yes" if (ins & medicaid).present?
    "no"
  end

  def accepts_medicare
    return "yes" if insurers.map{|i| i.name}.include? 'Medicare'
    "no"
  end
end