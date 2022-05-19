require 'rails_helper'

describe 'Usuário cadastra novo Veículo' do
  it 'com sucesso' do
    user = User.create!(name: 'Jefferson Luis', email: 'jef@alfatransportes.com.br', password: 'jabuticaba')

    carrier = Carrier.create!(
      brand_name: 'Entregas Cometa', corporate_name: 'Viação Cometa LTDA', email_domain: '@cometa.com.br',
      taxpayer_number: '09812345678901', status: 'active'
    )

    login_as(user)
    visit root_path
    click_on('Veículos')
    click_on('Cadastrar Veículo')
    fill_in 'Modelo', with: 'Trucker 2072'
    fill_in 'Marca', with: 'Volksvagem'
    fill_in 'Ano', with: '2022'
    fill_in 'Placa', with: 'ETY7654'
    fill_in 'Transportadora', with: '1'
    click_on 'Enviar'

    expect(page).to have_content('Trucker 2072')
    expect(page).to have_content('ETY7654')
  end
end
