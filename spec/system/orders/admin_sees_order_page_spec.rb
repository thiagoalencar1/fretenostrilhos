require 'rails_helper'

describe 'Administrador vista página de ordens' do
  it 'e vê título da página' do
    # Arrange
    admin = Admin.create!(name: 'Manoel de Barros', email: 'manoel@sistemadefrete.com.br', password: '123456')

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Pedidos')

    # Assert
    expect(page).to have_content('Pedidos')
  end

  it 'e vê número informações de uma ordem ' do
    # Arrange
    carrier = Carrier.create!(
      brand_name: 'Alpha Transportes', corporate_name: 'Alta Transportes LTDA',
      email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )

    distance1 = DeliveryDistance.create!(from_km: '0', to_km: '100')
    distance2 = DeliveryDistance.create!(from_km: '101', to_km: '200')
    distance3 = DeliveryDistance.create!(from_km: '201', to_km: '300')
    distance4 = DeliveryDistance.create!(from_km: '301', to_km: '400')
    distance5 = DeliveryDistance.create!(from_km: '401', to_km: '500')

    DeliveryTime.create!(delivery_distance_id: distance1.id, carrier_id: carrier.id, time: 1)
    DeliveryTime.create!(delivery_distance_id: distance2.id, carrier_id: carrier.id, time: 2)
    DeliveryTime.create!(delivery_distance_id: distance3.id, carrier_id: carrier.id, time: 3)
    DeliveryTime.create!(delivery_distance_id: distance4.id, carrier_id: carrier.id, time: 4)
    DeliveryTime.create!(delivery_distance_id: distance5.id, carrier_id: carrier.id, time: 5)

    # 0.001 - 0.500
    PriceRange.create!(volume_start: '0.001', volume_end: '0.500', weight_start: '0.000', weight_end: '10.000')
    PriceRange.create!(volume_start: '0.001', volume_end: '0.500', weight_start: '10.000', weight_end: '30.000')
    PriceRange.create!(volume_start: '0.001', volume_end: '0.500', weight_start: '30.000', weight_end: '9999.000')
    # 0.501 - 1.000
    PriceRange.create!(volume_start: '0.501', volume_end: '1.000', weight_start: '0.000', weight_end: '10.000')
    PriceRange.create!(volume_start: '0.501', volume_end: '1.000', weight_start: '10.000', weight_end: '30.000')
    PriceRange.create!(volume_start: '0.501', volume_end: '1.000', weight_start: '30.000', weight_end: '9999.000')
    # 1.001 - 1.500
    PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '0.000', weight_end: '10.000')
    PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '10.000', weight_end: '30.000')
    PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '30.000', weight_end: '9999.000')
    # 1.501 - 2.000
    PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '0.000', weight_end: '10.000')
    PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '10.000', weight_end: '30.000')
    PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '30.000', weight_end: '9999.000')

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
    vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: '1')
    user = User.create!(name: 'Jefferson Luis', email: 'jef@alphatransportes.com.br', password: '123456')
    admin = Admin.create!(name: 'Manoel de Barros', email: 'manoel@sistemadefrete.com.br', password: '123456')
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123453284734')
    order = Order.create!(
      order_value: 100.20, package_volume: 1.5, package_weight: 3, distance: 100,
      delivery_date: 1.week.from_now, carrier_id: Carrier.first.id,
      origin_address: 'Rua das Acácias, 235, Salvador, Bahia, Brazil', destiny_address: 'Rua Borges de Barros 35, Ipiaú, Bahia, Brasil'
    )

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Pedidos')

    # Assert
    expect(page).to have_content('Pedidos')
    expect(page).to have_content('ABC123453284734')
    expect(page).to have_content('Alpha Transportes')
  end
end
