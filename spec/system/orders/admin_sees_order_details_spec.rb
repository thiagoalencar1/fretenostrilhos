require 'rails_helper'

describe 'Admin entra em um pedido' do
  it 'e vê os detalhes' do
    # Arrange
    carrier = Carrier.create!(
      brand_name: 'Alfa Transportes', corporate_name: 'Alfa Transportes LTDA',
      email_domain: 'alfatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )
    vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: '1')
    admin = Admin.create!(name: 'Manoel de Barros', email: 'manoel@sistemadefrete.com.br', password: '123456')
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
    expect(page).to have_content('Alfa Transportes')
  end
end
