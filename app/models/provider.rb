class Provider < ActiveRecord::Base
  validates :name, :clinic_id, presence: true
  validates_inclusion_of :icon, in: [nil, '', 'arnp', 'atrbc', 'cdpt', 'cn', 'cnm', 'dc', 'eamp', 'ibclc', 'licsw', 'lmft', 'msw', 'pac', 'phd', 'psyd', 'pt']

  belongs_to :clinic
  delegate :street_address, :city, :zip, :phone, :website, to: :clinic

  has_many :provider_insurers, dependent: :destroy, inverse_of: :provider
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

  # TODO: make these work with joins so they return AR associations
  def self.accepts_medicaid
    Provider.all.select{|p| p.accepts_medicaid }
  end

  def self.accepts_medicare
    Provider.all.select{|p| p.accepts_medicare }
  end

  # RailsAdmin uses this to show the dropdown of choices for icon attr
  def icon_enum
    [[nil], [''], ['arnp'], ['atrbc'], ['cn'], ['cdpt'], ['cnm'], ['dc'], ['eamp'], ['ibclc'], ['licsw'], ['lmft'], ['msw'], ['pac'], ['phd'], ['psyd'], ['pt']]
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
    insurers.where(is_medicaid: true).present?
  end

  def accepts_medicare
    insurers.where(is_medicare: true).present?
  end
end