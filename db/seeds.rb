clinic = Clinic.create(name: "Test Clinic", street_address: "123 Pine St", city: "Seattle", zip: "98122", phone: "206-206-1206", website: "coolclinic.com")
puts "Created 1 clinic"

10.times do |i|
  Provider.create(name: "Dr. Feelgood the #{i}th", clinic_id: clinic.id)
end
puts "Created 10 providers"

Insurer.create(name: "Blue Cross")
Insurer.create(name: "Premera")
puts "Created 2 insurers"

ProviderInsurer.create(provider_id: Provider.first.id, insurer_id: Insurer.first.id)
ProviderInsurer.create(provider_id: Provider.last.id, insurer_id: Insurer.last.id)
ProviderInsurer.create(provider_id: Provider.first.id, insurer_id: Insurer.last.id)
ProviderInsurer.create(provider_id: Provider.last.id, insurer_id: Insurer.first.id)
puts "Created 4 provider_insurers"

User.create(email: "admin@example.com", password: "password", password_confirmation: "password", role: "admin")
User.create(email: "superadmin@example.com", password: "password", password_confirmation: "password", role: "superadmin")
User.create(email: "user@example.com", password: "password", password_confirmation: "password", role: "user")
puts "Created 3 users"