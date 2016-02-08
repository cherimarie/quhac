class ProviderInsurer < ActiveRecord::Base
  validates :provider_id, :insurer_id, presence: true
  belongs_to :insurer
  belongs_to :provider
end
