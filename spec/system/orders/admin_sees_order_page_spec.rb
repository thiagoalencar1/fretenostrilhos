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
    order = Order.create!(distance: '101', carrier_id: carrier.id)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC12345')

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Pedidos')

    # Assert
    expect(page).to have_content('Pedidos')
    # expect(page).to have_content('Pedido: ABC12345')
    expect(page).to have_content('Alfa Transportes')
  end
end
