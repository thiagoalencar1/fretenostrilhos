require 'rails_helper'

RSpec.describe PriceRange, type: :model do
  describe '#valid?' do
    it 'falso quando _volume_start_ for vazio' do
      # Arrange
      carrier = Carrier.create!(
        brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTD',
        email_domain: 'expressomercurio.com.br', taxpayer_number: '00440695000122',
        status: 'active'
      )

      price_range = PriceRange.new(volume_start: '', volume_end: '0.999', weight_start: '1.000', weight_end: '1.500')

      # Act and Assert
      expect(price_range).not_to be_valid
    end

    it 'falso quando _volume_end_ for vazio' do
      # Arrange
      carrier = Carrier.create!(
        brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTD',
        email_domain: 'expressomercurio.com.br', taxpayer_number: '00440695000122',
        status: 'active'
      )

      price_range = PriceRange.new(volume_start: '0.01', volume_end: '', weight_start: '1.000', weight_end: '1.500')

      # Act and Assert
      expect(price_range).not_to be_valid
    end

    it 'falso quando _weight_start_ for vazio' do
      # Arrange
      carrier = Carrier.create!(
        brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTD',
        email_domain: 'expressomercurio.com.br', taxpayer_number: '00440695000122',
        status: 'active'
      )

      price_range = PriceRange.new(volume_start: '0.01', volume_end: '', weight_start: '', weight_end: '1.500')

      # Act and Assert
      expect(price_range).not_to be_valid
    end

    it 'falso quando _weight_end_ for vazio' do
      # Arrange
      carrier = Carrier.create!(
        brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTD',
        email_domain: 'expressomercurio.com.br', taxpayer_number: '00440695000122',
        status: 'active'
      )

      price_range = PriceRange.new(volume_start: '0.01', volume_end: '0.999', weight_start: '1.000', weight_end: '')

      # Act and Assert
      expect(price_range).not_to be_valid
    end
  end
end
