class Clinic < ActiveRecord::Base
  validates :street_address, :phone, :city, :zip, presence: true

  has_many :providers
end