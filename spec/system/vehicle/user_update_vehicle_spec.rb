require 'rails_helper'

describe 'Usuário edita cadastro de Transportadora' do
  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Jefferson Luis', email: 'jef@alfatransportes.com.br', password: 'jabuticaba')

    carrier = Carrier.create!(
      brand_name: 'Entregas Cometa', corporate_name: 'Viação Cometa LTDA', email_domain: '@cometa.com.br',
      taxpayer_number: '09812345678901', status: 'active'
    )

    Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: '1')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Veículo'
    click_on 'Editar'
    fill_in 'Modelo', with: 'Kia Bongo K2500'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq vehicles_path
    expect(page).to have_content('Kia Bongo K2500')
  end

  it 'sem sucesso' do
    # Arrange
    user = User.create!(name: 'Jefferson Luis', email: 'jef@alfatransportes.com.br', password: 'jabuticaba')

    carrier = Carrier.create!(
      brand_name: 'Entregas Cometa', corporate_name: 'Viação Cometa LTDA', email_domain: '@cometa.com.br',
      taxpayer_number: '09812345678901', status: 'active'
    )

    vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: '1')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Veículo'
    click_on 'Editar'
    fill_in 'Modelo', with: ''
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq vehicle_path(vehicle.id)
    expect(page).to have_content('Verifique o preenchimento do cadastro.')
  end
end
