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
      brand_name: 'Alfa Transportes', corporate_name: 'Alfa Transportes LTDA',
      email_domain: 'alfatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )
    vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: '1')
    user = User.create!(name: 'Jefferson Luis', email: 'jef@alfatransportes.com.br', password: '123456')
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
    expect(page).to have_content('Alfa Transportes')
  end
end
