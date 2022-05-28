require 'rails_helper'

describe 'Usuário visita página de intervalos de distância' do
  it 'para cadastro de prazo estimado' do
    # Arrange
    carrier = Carrier.create!(
      brand_name: 'Alfa Transportes', corporate_name: 'Alta Transportes LTDA',
      email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )

    user = User.create!(name: 'Juliano Costa', email: 'juliano@alphatransportes.com.br', password: 'chuchubeleza')

    distance1 = DeliveryDistance.create!(from_km: '0', to_km: '100')
    distance2 = DeliveryDistance.create!(from_km: '101', to_km: '200')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on('Prazos')
    first(:link, 'Cadastrar').click

    # Assert
    expect(page).to have_content('Entre 0 km — 100 km')
    fill_in 'Tempo estimado', with: '1'
    click_on('Salvar')
    expect(current_path).to eq(user_delivery_times_path)
    expect(page).to have_content('Estimativa de entrega cadastrada com sucesso.')
  end
end
