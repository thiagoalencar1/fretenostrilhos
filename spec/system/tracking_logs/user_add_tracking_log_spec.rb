require 'rails_helper'

describe 'Usuário entra nos detalhes do pedido' do
  it 'e cadastra atualização de rota' do
    # Arrange
    carrier = Carrier.create!(
      brand_name: 'Alpha Transportes', corporate_name: 'Alta Transportes LTDA',
      email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active')

    distance = DeliveryDistance.create!(from_km: '201', to_km: '300')
    DeliveryTime.create!(delivery_distance_id: distance.id, carrier_id: carrier.id, time: 3)

    PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '0.000', weight_end: '10.000')

    DistancePrice.create!(km_price: 1.0, price_range_id: 1, carrier_id: 1)

    user = User.create!(name: 'Jota Lima', email: 'jotalima@alphatransportes.com.br', password: '123456')
    
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
    click_on('Adicionar Atualização de Rota')
    fill_in('Descrição', with: 'Chegou na filial da transportadora em Jequié')
    fill_in('Local', with: 'Jequié, Bahia, Brasil')
    click_on('Atualizar Rota')

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Chegou na filial da transportadora em Jequié')
    expect(page).to have_content('Jequié, Bahia, Brasil')
  end

  it 'e não consegue atualizar rota' do
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
    click_on('Adicionar Atualização de Rota')
    fill_in('Descrição', with: '')
    fill_in('Local', with: 'Jequié, Bahia, Brasil')
    click_on('Atualizar Rota')

    # Assert
    expect(page).to have_content('Atualização de rota não registrada. Confira o preenchimento.')
  end
end
