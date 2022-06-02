require 'rails_helper'

RSpec.describe DeliveryDistance, type: :model do
  describe '#valid?' do
    context 'presença' do
      it 'Falso quando _from_km_ for vazio' do
        delivery_distance = DeliveryDistance.new(from_km: '', to_km: '0')
        delivery_distance.valid?
        result = delivery_distance.errors.include? :from_km
        expect(result).to be true
      end

      it 'Falso quando _to_km_ for vazio' do
        delivery_distance = DeliveryDistance.new(from_km: '0', to_km: '')
        delivery_distance.valid?
        result = delivery_distance.errors.include? :to_km
        expect(result).to be true
      end
    end

    context 'unicidade' do
      it 'Falso quando _from_km_ já estiver cadastrado' do
        DeliveryDistance.create!(from_km: '100', to_km: '101')
        delivery_distance = DeliveryDistance.new(from_km: '100', to_km: '200')
        delivery_distance.valid?
        result = delivery_distance.errors.include? :from_km
        expect(result).to be true
      end

      it 'Falso quando _to_km_ já estiver cadastrado' do
        DeliveryDistance.create!(from_km: '101', to_km: '200')
        delivery_distance = DeliveryDistance.new(from_km: '100', to_km: '200')
        delivery_distance.valid?
        result = delivery_distance.errors.include? :to_km
        expect(result).to be true
      end
    end
  end
end
