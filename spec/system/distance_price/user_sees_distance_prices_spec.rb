require 'rails_helper'

describe 'User entra na Tabela de Preços' do
  it 'e vê preços nos respectivos intervalos' do
    # Arrange
    carrier = Carrier.create!(
      brand_name: 'Alfa Transportes', corporate_name: 'Alta Transportes LTDA',
      email_domain: 'alfatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )

    user = User.create!(name: 'Jefferson Luis', email: 'jef@alfatransportes.com.br', password: 'jabuticaba')

    price_range = PriceRange.create!(
      volume_start: '0.500', volume_end: '0.999',
      weight_start: '1.000', weight_end: '1.499'
    )

    distance_price = DistancePrice.create!(
      km_price: '0.50',
      carrier_id: carrier.id,
      price_range_id: price_range.id
    )

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on('Tabela de Preços')

    # Assert
    expect(page).to have_content('0,500 m³')
    expect(page).to have_content('1,000 m³')
    expect(page).to have_content('1,000 kg')
    expect(page).to have_content('1,500 kg')
    expect(page).to have_content('R$ 0,50')
  end
end
