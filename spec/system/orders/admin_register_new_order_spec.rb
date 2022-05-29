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
    user = User.create!(name: 'Jefferson Luis', email: 'jef@alfatransportes.com.br', password: '123456')
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
    select 'Alfa Transportes', from: 'Transportadora'
    click_on('Enviar')

    # Assert
    expect(current_path).to eq orders_path
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
