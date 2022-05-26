require 'rails_helper'

RSpec.describe DeliveryTime, type: :model do
  describe '#valid?' do
    it 'falso quando _time_ for vazio' do
      # Arrange
      carrier = Carrier.create!(
        brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTD',
        email_domain: 'expressomercurio.com.br', taxpayer_number: '00440695000122',
        status: 'active'
      )

      user = User.create!(name: 'Juliano Costa', email: 'juliano@expressomercurio.com.br', password: 'chuchubeleza')

      distance1 = DeliveryDistance.create!(from_km: '0', to_km: '100')
      distance2 = DeliveryDistance.create!(from_km: '101', to_km: '200')

      # Act
      delivery_time = DeliveryTime.new(delivery_distance_id: distance1.id, carrier_id: carrier.id, time: '')

      # Assert
      expect(delivery_time).not_to be_valid
    end

    it 'falso quando _time_ for menor que 1' do
      # Arrange
      carrier = Carrier.create!(
        brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTD',
        email_domain: 'expressomercurio.com.br', taxpayer_number: '00440695000122',
        status: 'active'
      )

      user = User.create!(name: 'Juliano Costa', email: 'juliano@expressomercurio.com.br', password: 'chuchubeleza')

      distance1 = DeliveryDistance.create!(from_km: '0', to_km: '100')
      distance2 = DeliveryDistance.create!(from_km: '101', to_km: '200')

      # Act
      delivery_time = DeliveryTime.new(delivery_distance_id: distance1.id, carrier_id: carrier.id, time: 0)

      # Assert
      expect(delivery_time).not_to be_valid
    end

    it 'falso quando _time_ for maior que 99' do
      # Arrange
      carrier = Carrier.create!(
        brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTD',
        email_domain: 'expressomercurio.com.br', taxpayer_number: '00440695000122',
        status: 'active'
      )

      user = User.create!(name: 'Juliano Costa', email: 'juliano@expressomercurio.com.br', password: 'chuchubeleza')

      distance1 = DeliveryDistance.create!(from_km: '0', to_km: '100')
      distance2 = DeliveryDistance.create!(from_km: '101', to_km: '200')

      # Act
      delivery_time = DeliveryTime.new(delivery_distance_id: distance1.id, carrier_id: carrier.id, time: 0)

      # Assert
      expect(delivery_time).not_to be_valid
    end

    it 'falso quando _delivery_distance_id_ for duplicado' do
      # Arrange
      carrier = Carrier.create!(
        brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTD',
        email_domain: 'expressomercurio.com.br', taxpayer_number: '00440695000122',
        status: 'active'
      )

      user = User.create!(name: 'Juliano Costa', email: 'juliano@expressomercurio.com.br', password: 'chuchubeleza')

      distance1 = DeliveryDistance.create!(from_km: '0', to_km: '100')
      distance2 = DeliveryDistance.create!(from_km: '101', to_km: '200')

      # Act
      DeliveryTime.create!(delivery_distance_id: distance1.id, carrier_id: carrier.id, time: 1)
      delivery_time = DeliveryTime.new(delivery_distance_id: distance1.id, carrier_id: carrier.id, time: 1)
      # Assert
      expect(delivery_time).not_to be_valid
    end
  end
end
