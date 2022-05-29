require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi aceito' do
    # Arrange
    carrier = Carrier.create!(
      brand_name: 'Alpha Transportes', corporate_name: 'Alfa Transportes LTDA',
      email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )
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
    click_on('Aceitar')
    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Situação do Pedido: Aceito')
  end

  it 'e pedido foi rejeitado' do
    # Arrange
    carrier = Carrier.create!(
      brand_name: 'Alpha Transportes', corporate_name: 'Alfa Transportes LTDA',
      email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )
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
    click_on('Rejeitar Pedido')
    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Situação do Pedido: Rejeitado')
  end

  it 'e pedido foi entregue' do
    # Arrange
    carrier = Carrier.create!(
      brand_name: 'Alpha Transportes', corporate_name: 'Alfa Transportes LTDA',
      email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )
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
    click_on('Aceitar Pedido')
    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Situação do Pedido: Aceito')
  end
end
