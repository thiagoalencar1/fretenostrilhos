require 'rails_helper'

RSpec.describe Carrier, type: :model do
  describe '#valid?' do
    it 'falso quando _brand_name_ for vazio' do
      # Arrange
      carrier = Carrier.new(
        brand_name: '', corporate_name: 'Expresso Mercúrio LTDA',
        email_domain: '@expressomercurio.com.br', taxpayer_number: '00440695000122',
        status: 'active'
      )
      # Act and Assert
      expect(carrier).not_to be_valid
    end

    it 'falso quando _corporate_name_ for vazio' do
      # Arrange
      carrier = Carrier.new(
        brand_name: 'Expresso Mercúrio', corporate_name: '',
        email_domain: '@expressomercurio.com.br', taxpayer_number: '00440695000122',
        status: 'active'
      )
      # Act and Assert
      expect(carrier).not_to be_valid
    end

    it 'falso quando _email_domain_ for vazio' do
      # Arrange
      carrier = Carrier.new(
        brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTD',
        email_domain: '', taxpayer_number: '00440695000122',
        status: 'active'
      )
      # Act and Assert
      expect(carrier).not_to be_valid
    end

    it 'falso quando _taxpayer_number_ for vazio' do
      # Arrange
      carrier = Carrier.new(
        brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTD',
        email_domain: '@expressomercurio.com.br', taxpayer_number: '',
        status: 'active'
      )
      # Act and Assert
      expect(carrier).not_to be_valid
    end

    it 'falso quando _status_ for vazio' do
      # Arrange
      carrier = Carrier.new(
        brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTD',
        email_domain: '@expressomercurio.com.br', taxpayer_number: '',
        status: ''
      )

      # Act and Assert
      expect(carrier).not_to be_valid
    end
  end
end
