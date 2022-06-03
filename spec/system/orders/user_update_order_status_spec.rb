require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi aceito' do
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
    
    order = Order.create!(
      package_weight: '10', package_volume: '1.2', distance: '300', order_value: '61.78',
      carrier:, origin_address: 'Rua Borges de Barros, Ipiaú, Bahia Brasil',
      destiny_address: 'Coreto da Praça, Mucugê, Bahia, Brasil', delivery_date: 3.days.from_now
    )

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on('Pedidos')
    click_on('Ver Pedido')
    click_on('Aceitar Pedido')

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Pedido aceito')
    expect(page).to have_content('Situação do Pedido: Aceito')
    expect(page).not_to have_content('Aceitar Pedido')
    expect(page).not_to have_content('Rejeitar Pedido')
    expect(page).to have_content('Marcar como Entregue')
  end

  it 'e pedido foi rejeitado' do
    # Arrange
    carrier = Carrier.create!(
      brand_name: 'Alpha Transportes', corporate_name: 'Alta Transportes LTDA',
      email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )

    distance = DeliveryDistance.create!(from_km: '201', to_km: '300')
    
    DeliveryTime.create!(delivery_distance_id: distance.id, carrier_id: carrier.id, time: 1)
    
    price_range = PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '30.000', weight_end: '9999.000')
    
    DistancePrice.create!(km_price: 0.90, price_range_id: price_range.id, carrier_id: 1)
    
    user = User.create!(name: 'Jota Lima', email: 'jotalima@alphatransportes.com.br', password: '123456') 
    
    Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: 1) 
    
    order = Order.create!(
      package_weight: '10', package_volume: '1.2', distance: '300', order_value: '61.78',
      carrier:, origin_address: 'Rua Borges de Barros, Ipiaú, Bahia Brasil',
      destiny_address: 'Coreto da Praça, Mucugê, Bahia, Brasil', delivery_date: 3.days.from_now
    )

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on('Pedidos')
    click_on('Ver Pedido')
    click_on('Rejeitar Pedido')

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Pedido rejeitado.')
    expect(page).to have_content('Situação do Pedido: Rejeitado')
    expect(page).not_to have_content('Aceitar Pedido')
    expect(page).not_to have_content('Rejeitar Pedido')
    expect(page).not_to have_content('Marcar como Entregue')
  end

  it 'e pedido foi entregue' do
    # Arrange
    carrier = Carrier.create!(
      brand_name: 'Alpha Transportes', corporate_name: 'Alta Transportes LTDA',
      email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )

    distance = DeliveryDistance.create!(from_km: '201', to_km: '300')
    
    DeliveryTime.create!(delivery_distance_id: distance.id, carrier_id: carrier.id, time: 1)
    
    price_range = PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '30.000', weight_end: '9999.000')
    
    DistancePrice.create!(km_price: 0.90, price_range_id: price_range.id, carrier_id: 1)
    
    user = User.create!(name: 'Jota Lima', email: 'jotalima@alphatransportes.com.br', password: '123456') 
    
    Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: 1) 
    
    order = Order.create!(
      package_weight: '10', package_volume: '1.2', distance: '300', order_value: '61.78',
      carrier:, origin_address: 'Rua Borges de Barros, Ipiaú, Bahia Brasil',
      destiny_address: 'Coreto da Praça, Mucugê, Bahia, Brasil', delivery_date: 3.days.from_now
    )

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on('Pedidos')
    click_on('Ver Pedido')
    click_on('Aceitar Pedido')
    click_on('Marcar como Entregue')

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Pedido entregue!')
    expect(page).to have_content('Situação do Pedido: Entregue')
    expect(page).not_to have_content('Aceitar Pedido')
    expect(page).not_to have_content('Rejeitar Pedido')
    expect(page).not_to have_content('Marcar como Entregue')
  end
end
