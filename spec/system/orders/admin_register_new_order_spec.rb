require 'rails_helper'

describe 'Admin registra uma nova ordem' do
  it 'com sucesso' do
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
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('1A2B3C4D5E6F7G8')

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Pedidos')
    click_on('Novo Pedido')
    fill_in('Peso', with: '10')
    fill_in('Volume', with: '1.2')
    fill_in('Endereço de Origem', with: 'Rua Borges de Barros, Ipiaú, Bahia Brasil')
    fill_in('Endereço de Destino', with: 'Coreto da Praça, Mucugê, Bahia, Brasil')
    fill_in('Distância', with: '300')
    select 'Alpha Transportes', from: 'Transportadora'
    click_on('Enviar')

    # Assert
    expect(current_path).to eq order_path(Order.last)
    expect(page).to have_content('Pedido registrado com sucesso.')
    expect(page).to have_content('1A2B3C4D5E6F7G8')
  end

  it 'sem sucesso' do
    # Arrange
    carrier = Carrier.create!(
      brand_name: 'Alfa Transportes', corporate_name: 'Alfa Transportes LTDA',
      email_domain: 'alfatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )
    vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: '1')
    user = User.create!(name: 'Jefferson Luis', email: 'jef@alfatransportes.com.br', password: '123456')
    admin = Admin.create!(name: 'Manoel de Barros', email: 'manoel@sistemadefrete.com.br', password: '123456')

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Pedidos')
    click_on('Novo Pedido')
    fill_in('Peso', with: '10')
    fill_in('Volume', with: '1.2')
    fill_in('Endereço de Origem', with: 'Rua Borges de Barros, Ipiaú, Bahia Brasil')
    fill_in('Endereço de Destino', with: 'Coreto da Praça, Mucugê, Bahia, Brasil')
    fill_in('Distância', with: '300')
    select 'Alfa Transportes', from: 'Transportadora'

    click_on('Enviar')

    # Assert
    expect(current_path).to eq orders_path
    expect(page).to have_content('Pedido não registrado. Confira o preenchimento.')
  end
end
