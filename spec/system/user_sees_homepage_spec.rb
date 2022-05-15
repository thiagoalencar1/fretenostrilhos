require 'rails_helper'

describe 'Usuário visita página inicial' do
  it 'e vê nome da aplicação' do
    # Arrange
    # Act
    visit root_path

    # Assert
    expect(page).to have_content('Frete nos Trilhos')
  end
end
