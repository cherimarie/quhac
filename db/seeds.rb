10.times do |i|
  Provider.create(name: "Dr. Feelgood the #{i}th", city: "Seattle")
end

Insurer.create(name: "Blue Cross")
Insurer.create(name: "Premera")

ProviderInsurer.create(provider_id: Provider.first.id, insurer_id: Insurer.first.id)
ProviderInsurer.create(provider_id: Provider.last.id, insurer_id: Insurer.last.id)