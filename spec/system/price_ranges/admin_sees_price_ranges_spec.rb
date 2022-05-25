require 'rails_helper'

describe 'Admin entra na página de price_ranges' do
  it 'e vê a tabela de preços' do
    # Arrange
    admin = Admin.create!(name: 'Manoel De barros', email: 'manoel@sistemadefrete.com.br', password: 'jabuticaba')

    price_ranges1 = PriceRange.create!(
      volume_start: '0.500', volume_end: '0.999',
      weight_start: '1.000', weight_end: '1.500'
    )

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Intervalo de Preços')

    # Assert
    expect(page).to have_content('0,500 m³')
    expect(page).to have_content('1,000 m³')
    expect(page).to have_content('1,000 kg')
    expect(page).to have_content('1,500 kg')
  end
end
