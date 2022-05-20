require 'rails_helper'

describe 'Administrador cadastra nova transportadora' do
  it 'com sucesso' do
    admin = Admin.create!(name: 'Jefferson Luis', email: 'jef@alfatransportes.com.br', password: 'jabuticaba')

    login_as(admin, scope: :admin)
    visit root_path
    click_on('Transportadoras')
    click_on('Cadastrar Transportadora')
    fill_in 'Nome Fantasia', with: 'Expresso Mercúrio'
    fill_in 'Razão Social', with: 'Expresso Mercúrio LTDA'
    fill_in 'Domínio', with: '@expressomercurio.com.br'
    fill_in 'CNPJ', with: '00440695000122'
    click_on 'Enviar'

    expect(page).to have_content('Expresso Mercúrio')
    expect(page).to have_content('Expresso Mercúrio LTDA')
    expect(page).to have_content('@expressomercurio.com.br')
    expect(page).to have_content('00440695000122')
  end

  it 'sem sucesso' do
    admin = Admin.create!(name: 'Jefferson Luis', email: 'jef@alfatransportes.com.br', password: 'jabuticaba')

    login_as(admin, scope: :admin)
    visit root_path
    click_on('Transportadoras')
    click_on('Cadastrar Transportadora')
    fill_in 'Nome Fantasia', with: 'Expresso Mercúrio'
    fill_in 'Razão Social', with: 'Expresso Mercúrio LTDA'
    fill_in 'Domínio', with: '@expressomercurio.com.br'
    fill_in 'CNPJ', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Verifique o preenchimento do cadastro.')
  end
end
