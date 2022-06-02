require 'rails_helper'

describe 'Admin edita Intervalo de Distância' do
  it 'com sucesso' do
    # Arrange
    admin = Admin.create!(name: 'Manoel De barros', email: 'manoel@sistemadefrete.com.br', password: '123456')

    DeliveryDistance.create!(from_km: '0', to_km: '100')
    DeliveryDistance.create!(from_km: '101', to_km: '200')

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Intervalos de Distância')
    first(:link, 'Editar').click
    fill_in('De', with: '201')
    fill_in('Até', with: '300')
    click_on('Salvar')

    # Assert
    expect(page).to have_content('Intervalo de Distância atualizado com sucesso.')
    expect(page).to have_content('101km 200km')
    expect(page).to have_content('201km 300km')
  end
end
