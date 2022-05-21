require 'rails_helper'

describe 'Usuário cria tabela de preços' do
  it 'com sucesso' do
    # Arrange
    carrier = Carrier.create!(
      brand_name: 'Alfa Transportes', corporate_name: 'Alta Transportes LTDA',
      email_domain: 'alfatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )

    user = User.create!(name: 'Jefferson Luis', email: 'jef@alfatransportes.com.br', password: 'jabuticaba')

    price_range1 = PriceRange.create!(
      volume_start: '0.500', volume_end: '1.000',
      weight_start: '1.000', weight_end: '1.499'
    )

    price_range2 = PriceRange.create!(
      volume_start: '1.000', volume_end: '1.500',
      weight_start: '1.500', weight_end: '2.000'
    )

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Tabela de Preços'

    click_on 'Cadastrar Preço/Km'

    # Assert
    expect(page).to have_content('Volume')
  end
end
