class Insurer < ActiveRecord::Base
  validates :name, presence: true

  has_many :provider_insurers, inverse_of: :insurer
  has_many :providers, through: :provider_insurers

  rails_admin do
    configure :provider_insurers do
      visible(false)
    end
    configure :providers do
      visible(false)
    end
  end
end
