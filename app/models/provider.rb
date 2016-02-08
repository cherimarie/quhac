class Provider < ActiveRecord::Base
  validates :name, :city, presence: true
  has_many :provider_insurers
  has_many :insurers, through: :provider_insurers
end