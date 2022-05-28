require 'rails_helper'

describe 'Administrador edita cadastro de Transportadora' do
  it 'com sucesso' do
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
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: 'Expresso Cometa'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq admin_carrier_path(carrier.id)
    expect(page).to have_content('Expresso Cometa')
  end

  it 'sem sucesso' do
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
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Atualização não realizada.')
  end
end
