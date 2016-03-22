class Insurer < ActiveRecord::Base
  validates :name, presence: true

  has_many :provider_insurers
  has_many :providers, through: :provider_insurers
end
