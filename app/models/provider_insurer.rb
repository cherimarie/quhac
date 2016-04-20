class ProviderInsurer < ActiveRecord::Base
  belongs_to :insurer, inverse_of: :provider_insurers
  belongs_to :provider, inverse_of: :provider_insurers
end
