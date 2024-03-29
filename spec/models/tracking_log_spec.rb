require 'rails_helper'

RSpec.describe TrackingLog, type: :model do
  describe '#valid?' do
    it 'falso quando _what_ for vazio' do
      # Arrange
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
      PriceRange.create!(volume_start: '0.001', volume_end: '0.500', weight_start: '0.000', weight_end: '10.000')
      PriceRange.create!(volume_start: '0.001', volume_end: '0.500', weight_start: '10.000', weight_end: '30.000')
      PriceRange.create!(volume_start: '0.001', volume_end: '0.500', weight_start: '30.000', weight_end: '9999.000')
      # 0.501 - 1.000
      PriceRange.create!(volume_start: '0.501', volume_end: '1.000', weight_start: '0.000', weight_end: '10.000')
      PriceRange.create!(volume_start: '0.501', volume_end: '1.000', weight_start: '10.000', weight_end: '30.000')
      PriceRange.create!(volume_start: '0.501', volume_end: '1.000', weight_start: '30.000', weight_end: '9999.000')
      # 1.001 - 1.500
      PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '0.000', weight_end: '10.000')
      PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '10.000', weight_end: '30.000')
      PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '30.000', weight_end: '9999.000')
      # 1.501 - 2.000
      PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '0.000', weight_end: '10.000')
      PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '10.000', weight_end: '30.000')
      PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '30.000', weight_end: '9999.000')

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
      user = User.create!(name: 'Jota Lima', email: 'jotalima@alphatransportes.com.br', password: '123456')
      order = Order.new(
        package_weight: '10', package_volume: '1.2', distance: '300', order_value: '61.78',
        carrier:, origin_address: 'Rua Borges de Barros, Ipiaú, Bahia Brasil',
        destiny_address: 'Coreto da Praça, Mucugê, Bahia, Brasil', delivery_date: 3.days.from_now
      )
      tracking_log = TrackingLog.new(what: '', when: Time.now, where: 'Jequié, Bahia, Brasil')

      # Act and Assert
      expect(tracking_log).not_to be_valid
    end

    it 'falso quando _where_ for vazio' do
      # Arrange
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
      PriceRange.create!(volume_start: '0.001', volume_end: '0.500', weight_start: '0.000', weight_end: '10.000')
      PriceRange.create!(volume_start: '0.001', volume_end: '0.500', weight_start: '10.000', weight_end: '30.000')
      PriceRange.create!(volume_start: '0.001', volume_end: '0.500', weight_start: '30.000', weight_end: '9999.000')
      # 0.501 - 1.000
      PriceRange.create!(volume_start: '0.501', volume_end: '1.000', weight_start: '0.000', weight_end: '10.000')
      PriceRange.create!(volume_start: '0.501', volume_end: '1.000', weight_start: '10.000', weight_end: '30.000')
      PriceRange.create!(volume_start: '0.501', volume_end: '1.000', weight_start: '30.000', weight_end: '9999.000')
      # 1.001 - 1.500
      PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '0.000', weight_end: '10.000')
      PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '10.000', weight_end: '30.000')
      PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '30.000', weight_end: '9999.000')
      # 1.501 - 2.000
      PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '0.000', weight_end: '10.000')
      PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '10.000', weight_end: '30.000')
      PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '30.000', weight_end: '9999.000')

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
      user = User.create!(name: 'Jota Lima', email: 'jotalima@alphatransportes.com.br', password: '123456')
      order = Order.new(
        package_weight: '10', package_volume: '1.2', distance: '300', order_value: '61.78',
        carrier:, origin_address: 'Rua Borges de Barros, Ipiaú, Bahia Brasil',
        destiny_address: 'Coreto da Praça, Mucugê, Bahia, Brasil', delivery_date: 3.days.from_now
      )
      tracking_log = TrackingLog.new(what: 'Chegou na filial da transportadora em Jequié', when: Time.now, where: '')

      # Act and Assert
      expect(tracking_log).not_to be_valid
    end
  end
end
