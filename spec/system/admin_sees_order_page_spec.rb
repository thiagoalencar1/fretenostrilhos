require 'rails_helper'

describe 'Administrador vista página de ordens' do
  it 'e vê título da página' do
    # Arrange
    admin = Admin.create!(name: 'Manoel de Barros', email: 'manoel@sistemadefrete.com.br', password: 'jabuticaba')

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
    user = User.create!(name: 'Jefferson Luis', email: 'jef@alfatransportes.com.br', password: 'jabuticaba')
    admin = Admin.create!(name: 'Manoel de Barros', email: 'manoel@sistemadefrete.com.br', password: 'jabuticaba')
    order = Order.create(order_number: 'XYZ', order_value: '100.20', status: '1', user_id: user.id,
                         carrier_id: carrier.id)

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Pedidos')

    # Assert
    expect(page).to have_content('Pedidos')
    expect(page).to have_content('Pedido: XYZ')
    expect(page).to have_content('Transportadora: Alfa Transportes')
    expect(page).to have_content('Usuário responsável: jef@alfatransportes.com.br')
  end

  it 'e cadastra uma nova ordem' do
    # Arrange
    carrier = Carrier.create!(
      brand_name: 'Alfa Transportes', corporate_name: 'Alfa Transportes LTDA',
      email_domain: 'alfatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )
    vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: '1')
    user = User.create!(name: 'Jefferson Luis', email: 'jef@alfatransportes.com.br', password: 'jabuticaba')
    admin = Admin.create!(name: 'Manoel de Barros', email: 'manoel@sistemadefrete.com.br', password: 'jabuticaba')
    order = Order.create(order_number: 'XYZ', order_value: '100.20', status: '1', user_id: user.id,
                         carrier_id: carrier.id)
    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Pedidos')
    click_on('Novo Pedido')

    # Assert
    expect(page).to have_content('Novo Pedido')
    expect(page).to have_content('Distância (km):')
    expect(page).to have_content('Usuário Responsável:')
  end
end
