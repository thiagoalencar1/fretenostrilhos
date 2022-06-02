require 'rails_helper'

describe 'Admin entra em um pedido' do
  it 'e vê os detalhes do pedido' do
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
      package_weight: '10', package_volume: '1.2', distance: '300', order_value: '61.78',
      carrier:, origin_address: 'Rua Borges de Barros, Ipiaú, Bahia Brasil',
      destiny_address: 'Coreto da Praça, Mucugê, Bahia, Brasil', delivery_date: 3.days.from_now
    )

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Pedidos')
    click_on('Ver Pedido')

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('1A2B3C4D5E6F7G8')
    expect(page).to have_content('10')
    expect(page).to have_content('1.2')
    expect(page).to have_content('300')
    expect(page).to have_content('61.78')
    expect(page).to have_content('Rua Borges de Barros, Ipiaú, Bahia Brasil')
    expect(page).to have_content('Coreto da Praça, Mucugê, Bahia, Brasil')
    expect(page).to have_content(order.delivery_date)
    expect(page).to have_content('Alpha Transportes')
  end
end
