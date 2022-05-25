require 'rails_helper'

describe 'Admin registra uma nova ordem' do
  it 'com sucesso' do
    # Arrange
    carrier = Carrier.create!(
      brand_name: 'Alfa Transportes', corporate_name: 'Alfa Transportes LTDA',
      email_domain: 'alfatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )
    vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: '1')
    user = User.create!(name: 'Jefferson Luis', email: 'jef@alfatransportes.com.br', password: 'jabuticaba')
    admin = Admin.create!(name: 'Manoel de Barros', email: 'manoel@sistemadefrete.com.br', password: 'jabuticaba')

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC12345')

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Pedidos')
    click_on('Novo Pedido')
    fill_in('Distância (km):', with: '300')
    fill_in('Transportadora', with: carrier.id)
    click_on('Enviar')
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC12345')

    # Assert
    expect(current_path).to eq orders_path
    expect(page).to have_content('Pedido registrado com sucesso.')
    expect(page).to have_content('ABC12345')
  end

  it 'sem sucesso' do
    # Arrange
    carrier = Carrier.create!(
      brand_name: 'Alfa Transportes', corporate_name: 'Alfa Transportes LTDA',
      email_domain: 'alfatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )
    vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: '1')
    user = User.create!(name: 'Jefferson Luis', email: 'jef@alfatransportes.com.br', password: 'jabuticaba')
    admin = Admin.create!(name: 'Manoel de Barros', email: 'manoel@sistemadefrete.com.br', password: 'jabuticaba')

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Pedidos')
    click_on('Novo Pedido')
    fill_in('Distância (km):', with: '300')
    click_on('Enviar')

    # Assert
    expect(current_path).to eq orders_path
    expect(page).to have_content('Pedido não registrado. Confira o preenchimento.')
  end
end
