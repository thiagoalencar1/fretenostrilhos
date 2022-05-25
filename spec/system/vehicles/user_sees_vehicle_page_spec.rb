require 'rails_helper'

describe 'Usuário vê Veívulo' do
  it 'sem sucesso quando não está autenticado' do
    visit vehicles_path
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso quando está autenticado' do
    Carrier.create!(
      brand_name: 'Alfa Transportes', corporate_name: 'Alta Transportes LTDA',
      email_domain: 'alfatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )

    user = User.create!(name: 'Sérgio', email: 'sergio@alfatransportes.com.br', password: '123456')

    Carrier.create!(
      brand_name: 'Entregas Cometa', corporate_name: 'Viação Cometa LTDA', email_domain: 'cometa.com.br',
      taxpayer_number: '09812345678901', status: 'active'
    )

    Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: '1')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Veículos'

    expect(current_path).to eq vehicles_path
    expect(page).to have_content('Kia Bongo 2022')
  end

  it '' do
  end
end
