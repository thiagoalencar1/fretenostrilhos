# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Carrier.create!(
  brand_name: 'Alfa Transportes', corporate_name: 'Alta Transportes LTDA',
  email_domain: 'alfatransportes.com.br', taxpayer_number: '38554111000112',
  status: 'active'
)

Carrier.create!(
  brand_name: 'Beta Transportes', corporate_name: 'Beta Transportes LTDA',
  email_domain: 'betatransportes.com.br', taxpayer_number: '37846022000187',
  status: 'active'
)

Carrier.create!(
  brand_name: 'Gama Transportes', corporate_name: 'Gama Transportes LTDA',
  email_domain: 'gamatransportes.com.br', taxpayer_number: '93195868000175',
  status: 'active'
)

Admin.create!(name: 'Manoel de Barros', email: 'manoel@sistemadefrete.com.br', password: 'carambolas')
User.create!(name: 'Jefferson Luis', email: 'jef@alfatransportes.com.br', password: 'jabuticaba')

Vehicle.create!(
  model: 'Kia Bongo K2500', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: '1'
)

Vehicle.create!(
  model: 'Scania XT', brand: 'Scania', license_plate: 'JPV0I89', year: '2022', carrier_id: '2'
)

Vehicle.create!(
  model: 'Scania V8', brand: 'Scania', license_plate: 'LKO9I09', year: '2022', carrier_id: '3'
)

PriceRange.create!(
  volume_start: '0.001', volume_end: '0.500',
  weight_start: '0.000', weight_end: '10.000'
)

PriceRange.create!(
  volume_start: '0.001', volume_end: '0.500',
  weight_start: '10.000', weight_end: '30.000'
)

PriceRange.create!(
  volume_start: '0.001', volume_end: '0.500',
  weight_start: '30.000', weight_end: '9999.000'
)

PriceRange.create!(
  volume_start: '0.501', volume_end: '1.000',
  weight_start: '0.000', weight_end: '10.000'
)

PriceRange.create!(
  volume_start: '0.501', volume_end: '1.000',
  weight_start: '10.000', weight_end: '30.000'
)

PriceRange.create!(
  volume_start: '0.501', volume_end: '1.000',
  weight_start: '30.000', weight_end: '9999.000'
)
