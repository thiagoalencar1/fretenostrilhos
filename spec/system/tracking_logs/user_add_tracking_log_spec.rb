require 'rails_helper'

describe 'Usuário entra nos detalhes do pedido' do
  it 'e cadastra atualização de rota' do
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
    click_on('Adicionar Atualização de Rota')
    fill_in('Descrição', with: 'Chegou na filial da transportadora em Jequié')
    fill_in('Local', with: 'Jequié, Bahia, Brasil')
    fill_in('Data', with: 5.days.from_now)
    click_on('Atualizar Rota')

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Chegou na filial da transportadora em Jequié')
    expect(page).to have_content('Jequié, Bahia, Brasil')
    expect(page).to have_content(5.days.from_now)
  end
end
