require 'rails_helper'

describe 'Usuário vê Veívulo' do
  it 'sem sucesso quando não está autenticado' do
    visit root_path
    within('nav') do
      click_on 'Veículos'
    end
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso quando está autenticado' do
    user = User.create!(name: 'Sérgio', email: 'ex@mple.com', password: '123456')

    Carrier.create!(
      brand_name: 'Entregas Cometa', corporate_name: 'Viação Cometa LTDA', email_domain: '@cometa.com.br',
      taxpayer_number: '09812345678901', status: 'active'
    )

    Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: '1')

    login_as(user)
    visit root_path
    click_on 'Veículos'

    expect(current_path).to eq vehicles_path
    expect(page).to have_content('Kia Bongo 2022')
  end

  it '' do
  end
end
