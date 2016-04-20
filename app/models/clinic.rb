class Clinic < ActiveRecord::Base
  validates :street_address, :phone, :city, :zip, presence: true

  has_many :providers

  rails_admin do
    configure :providers do
      visible(false)
    end
  end

  def self.search(search)
    search_length = search.split.length
    where([(['lower(name) LIKE lower(?)'] * search_length).join(' AND ')] + search.split.map { |search| "%#{search}%" })
  end
end