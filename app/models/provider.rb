class Provider < ActiveRecord::Base
  validates :name, :city, presence: true
  has_many :provider_insurers
  has_many :insurers, through: :provider_insurers

  def self.search(search)
    search_length = search.split.length
    where([(['lower(name) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" }) +
    where([(['lower(city) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" }).order(:name)
  end
end