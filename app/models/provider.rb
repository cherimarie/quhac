class Provider < ActiveRecord::Base
  validates :name, :clinic_id, presence: true

  has_many :provider_insurers
  has_many :insurers, through: :provider_insurers
  belongs_to :clinic

  delegate :street_address, :city, :zip, :phone, :website, to: :clinic

  def self.search(search)
    search_length = search.split.length
    where([(['lower(name) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" })
  end
end