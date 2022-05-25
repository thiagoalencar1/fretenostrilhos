require 'rails_helper'

describe 'Admin entra na página de Intervalos de Distância' do
  it 'e vê a tabela de preços' do
    # Arrange
    admin = Admin.create!(name: 'Manoel De barros', email: 'manoel@sistemadefrete.com.br', password: 'jabuticaba')

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
    expect(page).to have_content('0 - 100 km')
    expect(page).to have_content('101 - 200 km')
    expect(page).to have_content('201 - 300 km')
    expect(page).to have_content('301 - 400 km')
    expect(page).to have_content('401 - 500 km')
  end
end
