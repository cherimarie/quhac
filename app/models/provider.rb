class Provider < ActiveRecord::Base
  validates :name, :clinic_id, presence: true

  has_many :provider_insurers
  has_many :insurers, through: :provider_insurers
  belongs_to :clinic

  delegate :street_address, :city, :zip, :phone, :website, to: :clinic

  self.inheritance_column = nil

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