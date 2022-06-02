require 'rails_helper'

describe 'Usuário registra novo Intervalo de Medidas' do
  it 'com sucesso' do
    # Arrange
    admin = Admin.create!(name: 'Manoel De barros', email: 'manoel@sistemadefrete.com.br', password: '123456')

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Intervalos de Medidas')
    click_on('Novo Intervalo de Medidas')
    fill_in('Volume mínimo', with: '0.1')
    fill_in('Volume máximo', with: '0.5')
    fill_in('Peso mínimo', with: '1')
    fill_in('Peso máximo', with: '10')
    click_on('Salvar')

    # Assert
    expect(page).to have_content('Intervalo de Medidas cadastrado com sucesso.')
    expect(page).to have_content('0,100 m³ 0,500 m³ 1,000 kg 10,000 kg')
  end
end

