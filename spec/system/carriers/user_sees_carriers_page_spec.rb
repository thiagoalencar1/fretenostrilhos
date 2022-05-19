require 'rails_helper'

describe 'Usuário vê transportadoras' do
  it 'se estiver autenticado' do
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir do menu' do
    user = User.create!(name: 'Sérgio', email: 'ex@mple.com', password: '123456')

    Carrier.create!(
      brand_name: 'Entregas Cometa', corporate_name: 'Viação Cometa LTDA', email_domain: '@cometa.com.br',
      taxpayer_number: '09812345678901', status: 'active'
    )

    login_as(user)
    visit root_path
    click_on 'Transportadoras'

    expect(current_path).to eq carriers_path
    expect(page).to have_content('Entregas Cometa')
  end

  it '' do
  end
end
