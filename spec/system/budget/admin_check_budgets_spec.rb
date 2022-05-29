require 'rails_helper'

describe 'Admin consulta orçamentos para um pedido' do
  it 'em todas transportadoras cadastradas' do
    # Arrange
    admin = Admin.create!(name: 'Manoel De barros', email: 'manoel@sistemadefrete.com.br', password: '123456')
    carrier = Carrier.create!(
      brand_name: 'Alpha Transportes', corporate_name: 'Alta Transportes LTDA',
      email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )

    distance1 = DeliveryDistance.create!(from_km: '0', to_km: '100')
    distance2 = DeliveryDistance.create!(from_km: '101', to_km: '200')
    distance3 = DeliveryDistance.create!(from_km: '201', to_km: '300')
    distance4 = DeliveryDistance.create!(from_km: '301', to_km: '400')
    distance5 = DeliveryDistance.create!(from_km: '401', to_km: '500')

    DeliveryTime.create!(delivery_distance_id: distance1.id, carrier_id: carrier.id, time: 1)
    DeliveryTime.create!(delivery_distance_id: distance2.id, carrier_id: carrier.id, time: 2)
    DeliveryTime.create!(delivery_distance_id: distance3.id, carrier_id: carrier.id, time: 3)
    DeliveryTime.create!(delivery_distance_id: distance4.id, carrier_id: carrier.id, time: 4)
    DeliveryTime.create!(delivery_distance_id: distance5.id, carrier_id: carrier.id, time: 5)

    # 0.001 - 0.500
    price_range1 = PriceRange.create!(volume_start: '0.001', volume_end: '0.500',
                                      weight_start: '0.000', weight_end: '10.000')
    price_range2 = PriceRange.create!(volume_start: '0.001', volume_end: '0.500',
                                      weight_start: '10.000', weight_end: '30.000')
    price_range3 = PriceRange.create!(volume_start: '0.001', volume_end: '0.500',
                                      weight_start: '30.000', weight_end: '9999.000')
    # 0.501 - 1.000
    price_range4 = PriceRange.create!(volume_start: '0.501', volume_end: '1.000',
                                      weight_start: '0.000', weight_end: '10.000')
    price_range5 = PriceRange.create!(volume_start: '0.501', volume_end: '1.000',
                                      weight_start: '10.000', weight_end: '30.000')
    price_range6 = PriceRange.create!(volume_start: '0.501', volume_end: '1.000',
                                      weight_start: '30.000', weight_end: '9999.000')
    # 1.001 - 1.500
    price_range7 = PriceRange.create!(volume_start: '1.001', volume_end: '1.500',
                                      weight_start: '0.000', weight_end: '10.000')
    price_range8 = PriceRange.create!(volume_start: '1.001', volume_end: '1.500',
                                      weight_start: '10.000', weight_end: '30.000')
    price_range9 = PriceRange.create!(volume_start: '1.001', volume_end: '1.500',
                                      weight_start: '30.000', weight_end: '9999.000')
    # 1.501 - 2.000
    price_range10 = PriceRange.create!(volume_start: '1.001', volume_end: '1.500',
                                       weight_start: '0.000', weight_end: '10.000')
    price_range11 = PriceRange.create!(volume_start: '1.001', volume_end: '1.500',
                                       weight_start: '10.000', weight_end: '30.000')
    price_range12 = PriceRange.create!(volume_start: '1.001', volume_end: '1.500',
                                       weight_start: '30.000', weight_end: '9999.000')

    # DistancePrice - AplhaTransportes - # 0.001 - 0.500
    DistancePrice.create!(km_price: 0.5, price_range_id: 1, carrier_id: 1)
    DistancePrice.create!(km_price: 0.8, price_range_id: 2, carrier_id: 1)
    DistancePrice.create!(km_price: 1.0, price_range_id: 3, carrier_id: 1)
    # DistancePrice - AplhaTransportes - # 0.501 - 1.000
    DistancePrice.create!(km_price: 0.75, price_range_id: 4, carrier_id: 1)
    DistancePrice.create!(km_price: 0.90, price_range_id: 5, carrier_id: 1)
    DistancePrice.create!(km_price: 1.05, price_range_id: 6, carrier_id: 1)
    # DistancePrice - AplhaTransportes - # 1.001 - 1.500
    DistancePrice.create!(km_price: 0.95, price_range_id: 7, carrier_id: 1)
    DistancePrice.create!(km_price: 1.10, price_range_id: 8, carrier_id: 1)
    DistancePrice.create!(km_price: 1.25, price_range_id: 9, carrier_id: 1)
    # DistancePrice - AplhaTransportes - # 1.501 - 2.000
    DistancePrice.create!(km_price: 1.05, price_range_id: 10, carrier_id: 1)
    DistancePrice.create!(km_price: 1.30, price_range_id: 11, carrier_id: 1)
    DistancePrice.create!(km_price: 1.50, price_range_id: 12, carrier_id: 1)

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Orçamento'
    fill_in 'Volume', with: '1'
    fill_in 'Peso', with: '2'
    fill_in 'Distância', with: '100'
    click_on 'Consultar'

    # Assert
    expect(page).to have_content('Alpha Transportes R$ 75.0 1 dias')
  end

  it 'e não encontra nenhuma transportadora' do
    # Arrange
    admin = Admin.create!(name: 'Manoel De barros', email: 'manoel@sistemadefrete.com.br', password: '123456')
    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Orçamento'
    fill_in 'Volume', with: '1'
    fill_in 'Peso', with: '2'
    fill_in 'Distância', with: '100'
    click_on 'Consultar'

    # Assert
    expect(page).to have_content('Nenhuma transportadora encontrada.')
  end
end
