require 'rails_helper'

describe 'Usuário visualiza detalhes de uma Transportadora' do
  it 'e vê mais informações' do
    # Arrange
    admin = Admin.create!(name: 'Jefferson Luis', email: 'jef@alfatransportes.com.br', password: 'jabuticaba')

    carrier = Carrier.create!(
      brand_name: 'Entregas Cometa', corporate_name: 'Viação Cometa LTDA', email_domain: 'cometa.com.br',
      taxpayer_number: '09812345678901', status: 'active'
    )

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Entregas Cometa'

    # Assert
    expect(current_path).to eq admin_carrier_path(carrier.id)
    expect(page).to have_content('cometa.com.br')
    expect(page).to have_content('09812345678901')
  end
end
