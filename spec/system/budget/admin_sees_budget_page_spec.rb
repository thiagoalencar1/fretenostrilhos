require 'rails_helper'

describe 'Admin visita página de orçamento' do
  it 'e não está logado' do
    # Arrange
    # Act
    visit budgets_orders_path
    # Assert
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end
  it 'e vê formulário para consulta de orçamento' do
    # Arrange
    admin = Admin.create!(name: 'Manoel De barros', email: 'manoel@sistemadefrete.com.br', password: '123456')

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Orçamento'

    # Assert
    expect(page).to have_content('Orçamento')
    expect(page).to have_field('Volume')
    expect(page).to have_field('Peso')
    expect(page).to have_field('Distância')
  end
end
