require 'rails_helper'

describe 'Usuario busca por um pedido' do
  it 'e não precisa estar logado' do
    # Act
    visit root_path

    # Assert
    within('nav') do
      expect(page).to have_field('Acompanhar Pedido')
      expect(page).to have_button('Acompanhar')
    end
  end

  it 'e encontra um pedido' do
    # Arrange
    admin = Admin.create!(name: 'Manoel de Barros', email: 'manoel@sistemadefrete.com.br', password: '123456')

    carrier = Carrier.create!(
      brand_name: 'Alpha Transportes', corporate_name: 'Alta Transportes LTDA',
      email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )

    user = User.create!(name: 'Jota Lima', email: 'jotalima@alphatransportes.com.br', password: '123456')

    distance = DeliveryDistance.create!(from_km: '0', to_km: '100')
    DeliveryTime.create!(delivery_distance_id: distance.id, carrier_id: carrier.id, time: 3)

    price_range = PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '0.000', weight_end: '10.000')
    DistancePrice.create!(km_price: 1.0, price_range_id: price_range.id, carrier_id: carrier.id)

    vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: '1')

    order = Order.create!(
      package_volume: 1.5, package_weight: 3, distance: 100,
      carrier:, origin_address: 'Rua das Acácias, 235, Salvador, Bahia, Brazil',
      destiny_address: 'Rua Borges de Barros 35, Ipiaú, Bahia, Brasil',
      order_value: 100.20, delivery_date: 3.days.from_now
    )

    # Act
    visit root_path
    fill_in 'Acompanhar Pedido', with: order.order_number
    click_on 'Acompanhar'

    # Assert
    expect(page).to have_content("Acompanhamento de Pedido\n#{order.order_number}")
    expect(page).to have_content("Código: #{order.order_number}")
  end

  it 'e não encontra um pedido' do
    # Arrange
    # Act
    visit root_path
    fill_in 'Acompanhar Pedido', with: 'XYZTHG980987656'
    click_on 'Acompanhar'

    # Assert
    expect(page).to have_content('Acompanhamento de Pedido')
    expect(page).to have_content('Pedido XYZTHG980987656 não encontrado')
  end

  it 'e vê histórico de atualizações do pedido' do
    admin = Admin.create!(name: 'Manoel de Barros', email: 'manoel@sistemadefrete.com.br', password: '123456')
    
    carrier = Carrier.create!(
      brand_name: 'Alpha Transportes', corporate_name: 'Alta Transportes LTDA',
      email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )

    user = User.create!(name: 'Jota Lima', email: 'jotalima@alphatransportes.com.br', password: '123456')

    distance = DeliveryDistance.create!(from_km: '201', to_km: '300')
    DeliveryTime.create!(delivery_distance_id: distance.id, carrier_id: carrier.id, time: 3)

    price_range = PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '0.000', weight_end: '10.000')
    DistancePrice.create!(km_price: 1.0, price_range_id: price_range.id, carrier_id: carrier.id)

    vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: '1')
    
    order = Order.create!(
      package_weight: 10, package_volume: 1.2, distance: 300,
      carrier:, origin_address: 'Rua Borges de Barros, Ipiaú, Bahia Brasil',
      destiny_address: 'Coreto da Praça, Mucugê, Bahia, Brasil',
      order_value: '61.78', delivery_date: 3.days.from_now
    )

    log1 = TrackingLog.create!(order_id: order.id, when: Time.now, what: 'Ordem criada.',
                               where: 'Rua das Acácias, 235, Salvador, Bahia, Brazil')
    log2 = TrackingLog.create!(order_id: order.id, when: Time.now, what: 'Saiu das instalações da transportadora.',
                               where: 'Rua das Acácias, 235, Salvador, Bahia, Brazil')
    log3 = TrackingLog.create!(order_id: order.id, when: Time.now, what: 'Chegou à filial da transportadora.',
                               where: 'Av. Rio Branco, 648, Centro, Jequié, Bahia, Brasil')
    log3 = TrackingLog.create!(order_id: order.id, when: Time.now, what: 'Saiu da filial da transportadora.',
                               where: 'Av. Rio Branco, 648, Centro, Jequié, Bahia, Brasil')
    log4 = TrackingLog.create!(order_id: order.id, when: Time.now, what: 'Chegou ao destino.',
                               where: 'Rua Borges de Barros 35, Ipiaú, Bahia, Brasil')

    # Act
    visit root_path
    fill_in 'Acompanhar Pedido', with: order.order_number
    click_on 'Acompanhar'

    # Assert
    expect(page).to have_content("Acompanhamento de Pedido\n#{order.order_number}")
    expect(page).to have_content("Código: #{order.order_number}")
    expect(page).to have_content('Rua das Acácias, 235, Salvador, Bahia, Brazil')
    expect(page).to have_content('Rua Borges de Barros 35, Ipiaú, Bahia, Brasil')
    expect(page).to have_content('Av. Rio Branco, 648, Centro, Jequié, Bahia, Brasil')
  end

  it 'e ainda não há histórico de atualizações do pedido' do
    admin = Admin.create!(name: 'Manoel de Barros', email: 'manoel@sistemadefrete.com.br', password: '123456')
    
    carrier = Carrier.create!(
      brand_name: 'Alpha Transportes', corporate_name: 'Alta Transportes LTDA',
      email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
      status: 'active'
    )

    user = User.create!(name: 'Jota Lima', email: 'jotalima@alphatransportes.com.br', password: '123456')

    distance = DeliveryDistance.create!(from_km: 0, to_km: 100)
    DeliveryTime.create!(delivery_distance_id: distance.id, carrier_id: carrier.id, time: 3)

    price_range = PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '0.000', weight_end: '10.000')
    DistancePrice.create!(km_price: 1.0, price_range_id: price_range.id, carrier_id: carrier.id)

    vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022', carrier_id: '1')
    
    order = Order.create!(
      order_value: 100.20, package_volume: 1.5, package_weight: 3, distance: 100,
      delivery_date: 1.week.from_now, carrier_id: Carrier.first.id,
      origin_address: 'Rua das Acácias, 235, Salvador, Bahia, Brazil', destiny_address: 'Rua Borges de Barros 35, Ipiaú, Bahia, Brasil'
    )

    # Act
    visit root_path
    fill_in 'Acompanhar Pedido', with: order.order_number
    click_on 'Acompanhar'

    # Assert
    expect(page).to have_content("Acompanhamento de Pedido\n#{order.order_number}")
    expect(page).to have_content("Código: #{order.order_number}")
    expect(page).to have_content('Nenhum registro de acompanhamento até agora. Consulte mais tarde.')
  end
end
