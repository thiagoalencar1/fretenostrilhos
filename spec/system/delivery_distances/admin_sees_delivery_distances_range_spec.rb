require 'rails_helper'

describe 'Admin entra na página de Intervalos de Distância' do
  it 'e vê a tabela de preços' do
    # Arrange
    admin = Admin.create!(name: 'Manoel De barros', email: 'manoel@sistemadefrete.com.br', password: '123456')

    DeliveryDistance.create!(from_km: '0', to_km: '100')
    DeliveryDistance.create!(from_km: '101', to_km: '200')
    DeliveryDistance.create!(from_km: '201', to_km: '300')
    DeliveryDistance.create!(from_km: '301', to_km: '400')
    DeliveryDistance.create!(from_km: '401', to_km: '500')

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Intervalos de Distância')

    # Assert
    expect(page).to have_content('0km 100km')
    expect(page).to have_content('101km 200km')
    expect(page).to have_content('201km 300km')
    expect(page).to have_content('301km 400km')
    expect(page).to have_content('401km 500km')
  end
end
