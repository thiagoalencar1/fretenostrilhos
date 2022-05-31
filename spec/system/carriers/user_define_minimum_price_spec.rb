require 'rails_helper'

describe 'Usuário cadastra preço mínimo para sua transportadora' do
  it 'com sucesso' do
    # Arrange
    carrier = Carrier.create!(
      brand_name: 'Alpha Transportes', corporate_name: 'Alta Transportes LTDA',
      email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )
    user = User.create!(name: 'Jota Lima', email: 'jotalima@alphatransportes.com.br', password: '123456')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on('Preços')
    click_on('Configurar valor mínimo de frete')
    fill_in('Valor mínimo de frete', with: '10.00')
    click_on('Salvar')

    # Assert
    expect(current_path).to eq user_distance_prices_path
    expect(page).to have_content('Preço mínimo definido com sucesso.')
  end
end
