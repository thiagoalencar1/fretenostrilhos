require 'rails_helper'

describe 'Usuário visita página de intervalos de distância' do
  it 'para cadastro de prazo' do
    # Arrange
    carrier = Carrier.create!(
      brand_name: 'Alfa Transportes', corporate_name: 'Alta Transportes LTDA',
      email_domain: 'alfatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )

    user = User.create!(name: 'Juliano Costa', email: 'juliano@alfatransportes.com.br', password: '123456')

    distance1 = DeliveryDistance.create!(from_km: '0', to_km: '100')
    distance2 = DeliveryDistance.create!(from_km: '101', to_km: '200')

    DeliveryTime.create!(delivery_distance_id: distance1.id, carrier_id: carrier.id, time: 2)
    DeliveryTime.create!(delivery_distance_id: distance2.id, carrier_id: carrier.id, time: 4)

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on('Prazos')

    # Assert
    expect(page).to have_content('100 km')
    expect(page).to have_content('200 km')
    expect(page).to have_content('2 dias')
    expect(page).to have_content('4 dias')
  end
end
