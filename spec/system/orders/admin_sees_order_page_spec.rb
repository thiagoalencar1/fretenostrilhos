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
    admin = Admin.create!(name: 'Manoel de Barros', email: 'manoel@sistemadefrete.com.br', password: '123456')
    
    carrier = Carrier.create!(
      brand_name: 'Alpha Transportes', corporate_name: 'Alta Transportes LTDA',
      email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )

    user = User.create!(name: 'Jota Lima', email: 'jotalima@alphatransportes.com.br', password: '123456')

    distance = DeliveryDistance.create!(from_km: '201', to_km: '300')
    DeliveryTime.create!(delivery_distance_id: distance.id, carrier_id: carrier.id, time: 3)

    price_range = PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '0.000', weight_end: '10.000')
    DistancePrice.create!(km_price: 1.0, price_range_id: price_range.id, carrier_id: carrier.id)

    vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: '1')
    
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('1A2B3C4D5E6F7G8')
    order = Order.create!(
      package_weight: 10, package_volume: 1.2, distance: 300,
      carrier:, origin_address: 'Rua Borges de Barros, Ipiaú, Bahia Brasil',
      destiny_address: 'Coreto da Praça, Mucugê, Bahia, Brasil',
      order_value: '61.78', delivery_date: 3.days.from_now
    )
    
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123453284734')
    order = Order.create!(
      package_weight: 3, package_volume: 1.4, distance: 300,
      carrier:, origin_address: 'Rua das Acácias, 235, Salvador, Bahia, Brazil',
      destiny_address: 'Rua Borges de Barros 35, Ipiaú, Bahia, Brasil',
      order_value: '100.97', delivery_date: 3.days.from_now
    )

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Pedidos')

    # Assert
    expect(page).to have_content('Pedidos')
    expect(page).to have_content('Alpha Transportes')
    expect(page).to have_content('ABC123453284734')
    expect(page).to have_content('Alpha Transportes')
  end
end
