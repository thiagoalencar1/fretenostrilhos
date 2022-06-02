require 'rails_helper'

describe 'Usuário edita o Intervalo de Medidas' do
  it 'com sucesso' do
    # Arrange
    admin = Admin.create!(name: 'Manoel De barros', email: 'manoel@sistemadefrete.com.br', password: '123456')

    PriceRange.create!(volume_start: 0.1, volume_end: 0.5, weight_start: 1, weight_end: 10)

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Intervalos de Medidas')
    first(:link, 'Editar').click
    fill_in('Volume mínimo', with: '0.2')
    fill_in('Volume máximo', with: '0.7')
    fill_in('Peso mínimo', with: '10')
    fill_in('Peso máximo', with: '100')
    click_on('Salvar')

    # Assert
    expect(page).to have_content('Intervalo de Medidas atualizado com sucesso.')
    expect(page).to have_content('0,200 m³ 0,700 m³ 10,000 kg 100,000 kg')
  end
end

