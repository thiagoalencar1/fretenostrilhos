# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Carrier.create!(
  brand_name: 'Alfa Transportes', corporate_name: 'Alta Transportes LTDA',
  email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
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

Admin.create!(name: 'Manoel de Barros', email: 'manoel@sistemadefrete.com.br', password: 'laranja')
User.create!(name: 'Jefferson Luis', email: 'jef@alphatransportes.com.br', password: 'laranja')
User.create!(name: 'Fernando Pessoa', email: 'pessoa@betatransportes.com.br', password: 'laranja')

Vehicle.create!(
  model: 'Kia Bongo K2500', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: '1'
)

Vehicle.create!(
  model: 'Scania XT', brand: 'Scania', license_plate: 'JPV0I89', year: '2022', carrier_id: '2'
)

Vehicle.create!(
  model: 'Scania V8', brand: 'Scania', license_plate: 'LKO9I09', year: '2022', carrier_id: '3'
)

Order.create(order_value: '100.20', status: '1', distance: '100', carrier_id: Carrier.first.id)

# 0.001 - 0.500
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

# 0.501 - 1.000
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

# 1.001 - 1.500
PriceRange.create!(
  volume_start: '1.001', volume_end: '1.500',
  weight_start: '0.000', weight_end: '10.000'
)
PriceRange.create!(
  volume_start: '1.001', volume_end: '1.500',
  weight_start: '10.000', weight_end: '30.000'
)
PriceRange.create!(
  volume_start: '1.001', volume_end: '1.500',
  weight_start: '30.000', weight_end: '9999.000'
)

# 1.501 - 2.000
PriceRange.create!(
  volume_start: '1.001', volume_end: '1.500',
  weight_start: '0.000', weight_end: '10.000'
)
PriceRange.create!(
  volume_start: '1.001', volume_end: '1.500',
  weight_start: '10.000', weight_end: '30.000'
)
PriceRange.create!(
  volume_start: '1.001', volume_end: '1.500',
  weight_start: '30.000', weight_end: '9999.000'
)

# DistancePrice - AplhaTransportes - # 0.001 - 0.500
DistancePrice.create!(km_price: 0.5, price_range_id: 1, carrier_id: 1)
DistancePrice.create!(km_price: 0.8, price_range_id: 2, carrier_id: 1)
DistancePrice.create!(km_price: 1.0, price_range_id: 3, carrier_id: 1)
# DistancePrice - AplhaTransportes - # 0.501 - 1.000
DistancePrice.create!(km_price: 0.75, price_range_id: 4, carrier_id: 1)
DistancePrice.create!(km_price: 0.90, price_range_id: 5, carrier_id: 1)
DistancePrice.create!(km_price: 1.05, price_range_id: 6, carrier_id: 1)
# DistancePrice - AplhaTransportes - # 1.001 - 1.500
DistancePrice.create!(km_price: 0.95, price_range_id: 7, carrier_id: 1)
DistancePrice.create!(km_price: 1.10, price_range_id: 8, carrier_id: 1)
DistancePrice.create!(km_price: 1.25, price_range_id: 9, carrier_id: 1)
# DistancePrice - AplhaTransportes - # 1.501 - 2.000
DistancePrice.create!(km_price: 1.05, price_range_id: 10, carrier_id: 1)
DistancePrice.create!(km_price: 1.30, price_range_id: 11, carrier_id: 1)
DistancePrice.create!(km_price: 1.50, price_range_id: 12, carrier_id: 1)

# DistancePrice - BetaTransportes - # 0.001 - 0.500
DistancePrice.create!(km_price: 0.5, price_range_id: 1, carrier_id: 2)
DistancePrice.create!(km_price: 0.8, price_range_id: 2, carrier_id: 2)
DistancePrice.create!(km_price: 1.0, price_range_id: 3, carrier_id: 2)
# DistancePrice - BetaTransportes - # 0.501 - 1.000
DistancePrice.create!(km_price: 0.75, price_range_id: 4, carrier_id: 2)
DistancePrice.create!(km_price: 0.90, price_range_id: 5, carrier_id: 2)
DistancePrice.create!(km_price: 1.05, price_range_id: 6, carrier_id: 2)
# DistancePrice - BetaTransportes - # 1.001 - 1.500
DistancePrice.create!(km_price: 0.95, price_range_id: 7, carrier_id: 2)
DistancePrice.create!(km_price: 1.10, price_range_id: 8, carrier_id: 2)
DistancePrice.create!(km_price: 1.25, price_range_id: 9, carrier_id: 2)
# DistancePrice - BetaTransportes - # 1.501 - 2.000
DistancePrice.create!(km_price: 1.05, price_range_id: 10, carrier_id: 2)
DistancePrice.create!(km_price: 1.30, price_range_id: 11, carrier_id: 2)

# Delivery Distance Ranges
DeliveryDistance.create!(from_km: '0', to_km: '100')
DeliveryDistance.create!(from_km: '101', to_km: '200')
DeliveryDistance.create!(from_km: '201', to_km: '300')
DeliveryDistance.create!(from_km: '301', to_km: '400')
DeliveryDistance.create!(from_km: '401', to_km: '500')
