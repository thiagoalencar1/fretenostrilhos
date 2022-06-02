require 'rails_helper'

describe 'Admin registra uma nova ordem' do
  it 'com sucesso' do
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
