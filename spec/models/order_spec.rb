require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    context '#preseça' do
      it 'falso quando _distance_ for vazio' do
        # Arrange
        carrier = Carrier.create!(
          brand_name: 'Alpha Transportes', corporate_name: 'Alta Transportes LTDA',
          email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
          status: 'active'
        )
        distance = DeliveryDistance.create!(from_km: '101', to_km: '200')
        DeliveryTime.create!(delivery_distance_id: distance.id, carrier_id: carrier.id, time: 1)
        PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '10.000', weight_end: '30.000')
        DistancePrice.create!(km_price: 0.5, price_range_id: 1, carrier_id: 1)
        vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022',
                                  carrier_id: '1')
        order = Order.new(
          package_weight: '10', package_volume: '1.2', distance: '', carrier:, order_value: '65.00',
          origin_address: 'Rua Borges de Barros, Ipiaú, Bahia Brasil', destiny_address: 'Coreto da Praça, Mucugê, Bahia, Brasil',
          delivery_date: 3.days.from_now
        )

        order.valid?

        # Act
        result = order.errors.include? :distance

        # Act and Assert
        expect(result).to be true
      end

      it 'falso quando _package_volume_ for vazio' do
        # Arrange
        carrier = Carrier.create!(
          brand_name: 'Alpha Transportes', corporate_name: 'Alta Transportes LTDA',
          email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
          status: 'active'
        )
        distance = DeliveryDistance.create!(from_km: '101', to_km: '200')
        DeliveryTime.create!(delivery_distance_id: distance.id, carrier_id: carrier.id, time: 1)
        PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '10.000', weight_end: '30.000')
        DistancePrice.create!(km_price: 0.5, price_range_id: 1, carrier_id: 1)
        vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022',
                                  carrier_id: '1')
        order = Order.new(
          package_weight: '10', package_volume: '', distance: '150', carrier:, order_value: '65.00',
          origin_address: 'Rua Borges de Barros, Ipiaú, Bahia Brasil', destiny_address: 'Coreto da Praça, Mucugê, Bahia, Brasil',
          delivery_date: 3.days.from_now
        )

        order.valid?

        # Act
        result = order.errors.include? :package_volume

        # Act and Assert
        expect(result).to be true
      end

      it 'falso quando _package_weight_ for vazio' do
        # Arrange
        carrier = Carrier.create!(
          brand_name: 'Alpha Transportes', corporate_name: 'Alta Transportes LTDA',
          email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
          status: 'active'
        )
        distance = DeliveryDistance.create!(from_km: '101', to_km: '200')
        DeliveryTime.create!(delivery_distance_id: distance.id, carrier_id: carrier.id, time: 1)
        PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '10.000', weight_end: '30.000')
        DistancePrice.create!(km_price: 0.5, price_range_id: 1, carrier_id: 1)
        vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022',
                                  carrier_id: '1')
        order = Order.new(
          package_weight: '', package_volume: '1.2', distance: '150', carrier:, order_value: '65.00',
          origin_address: 'Rua Borges de Barros, Ipiaú, Bahia Brasil', destiny_address: 'Coreto da Praça, Mucugê, Bahia, Brasil',
          delivery_date: 3.days.from_now
        )

        order.valid?

        # Act
        result = order.errors.include? :package_weight

        # Act and Assert
        expect(result).to be true
      end

      it 'falso quando _origin_address_ for vazio' do
        # Arrange
        carrier = Carrier.create!(
          brand_name: 'Alpha Transportes', corporate_name: 'Alta Transportes LTDA',
          email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
          status: 'active'
        )
        distance = DeliveryDistance.create!(from_km: '101', to_km: '200')
        DeliveryTime.create!(delivery_distance_id: distance.id, carrier_id: carrier.id, time: 1)
        PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '10.000', weight_end: '30.000')
        DistancePrice.create!(km_price: 0.5, price_range_id: 1, carrier_id: 1)
        vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022',
                                  carrier_id: '1')
        order = Order.new(
          package_weight: '10', package_volume: '1.2', distance: '150', carrier:, order_value: '65.00',
          origin_address: '', destiny_address: 'Coreto da Praça, Mucugê, Bahia, Brasil',
          delivery_date: 3.days.from_now
        )

        order.valid?

        # Act
        result = order.errors.include? :origin_address

        # Act and Assert
        expect(result).to be true
      end

      it 'falso quando _destiny_address_ for vazio' do
        # Arrange
        carrier = Carrier.create!(
          brand_name: 'Alpha Transportes', corporate_name: 'Alta Transportes LTDA',
          email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
          status: 'active'
        )
        distance = DeliveryDistance.create!(from_km: '101', to_km: '200')
        DeliveryTime.create!(delivery_distance_id: distance.id, carrier_id: carrier.id, time: 1)
        PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '10.000', weight_end: '30.000')
        DistancePrice.create!(km_price: 0.5, price_range_id: 1, carrier_id: 1)
        vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022',
                                  carrier_id: '1')
        order = Order.new(
          package_weight: '10', package_volume: '1.2', distance: '150', carrier:, order_value: '65.00',
          origin_address: 'Rua Borges de Barros, Ipiaú, Bahia Brasil', destiny_address: '',
          delivery_date: 3.days.from_now
        )

        order.valid?

        # Act
        result = order.errors.include? :destiny_address

        # Act and Assert
        expect(result).to be true
      end

      it 'falso quando _order_value_ for vazio' do
        # Arrange
        carrier = Carrier.create!(
          brand_name: 'Alpha Transportes', corporate_name: 'Alta Transportes LTDA',
          email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
          status: 'active'
        )
        distance = DeliveryDistance.create!(from_km: '101', to_km: '200')
        DeliveryTime.create!(delivery_distance_id: distance.id, carrier_id: carrier.id, time: 1)
        PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '10.000', weight_end: '30.000')
        DistancePrice.create!(km_price: 0.5, price_range_id: 1, carrier_id: 1)
        vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022',
                                  carrier_id: '1')
        order = Order.new(
          package_weight: '10', package_volume: '1.2', distance: '150', carrier:, order_value: '',
          origin_address: 'Rua Borges de Barros, Ipiaú, Bahia Brasil', destiny_address: 'Coreto da Praça, Mucugê, Bahia, Brasil',
          delivery_date: 3.days.from_now
        )

        order.valid?

        # Act
        result = order.errors.include? :order_value

        # Act and Assert
        expect(result).to be true
      end

      it 'falso quando _delivery_date_ for vazio' do
        # Arrange
        carrier = Carrier.create!(
          brand_name: 'Alpha Transportes', corporate_name: 'Alta Transportes LTDA',
          email_domain: 'alphatransportes.com.br', taxpayer_number: '38554111000112',
          status: 'active'
        )
        distance = DeliveryDistance.create!(from_km: '101', to_km: '200')
        DeliveryTime.create!(delivery_distance_id: distance.id, carrier_id: carrier.id, time: 1)
        PriceRange.create!(volume_start: '1.001', volume_end: '1.500', weight_start: '10.000', weight_end: '30.000')
        DistancePrice.create!(km_price: 0.5, price_range_id: 1, carrier_id: 1)
        vehicle = Vehicle.create!(model: 'Kia Bongo', brand: 'Kia', license_plate: 'QTY9I82', year: '2022',
                                  carrier_id: '1')
        order = Order.new(
          package_weight: '10', package_volume: '1.2', distance: '150', carrier:, order_value: '70.00',
          origin_address: 'Rua Borges de Barros, Ipiaú, Bahia Brasil', destiny_address: 'Coreto da Praça, Mucugê, Bahia, Brasil',
          delivery_date: ''
        )

        order.valid?

        # Act
        result = order.errors.include? :delivery_date

        # Act and Assert
        expect(result).to be true
      end
    end
  end
end
