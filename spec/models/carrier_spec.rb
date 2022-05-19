require 'rails_helper'

RSpec.describe Carrier, type: :model do
  describe '#valid?' do
    context 'preseça' do
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
    end

    it 'falso quando _taxpayer_number_ for menor ou maior do que 14 caracteres' do
      carrier = Carrier.new(
        brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTDA',
        email_domain: '@expressomercurio.com.br', taxpayer_number: '004406950001202',
        status: 'active'
      )
      expect(carrier).not_to be_valid
    end

    it 'falso quando _taxpayer_number_ não for numérico' do
      carrier = Carrier.new(
        brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTDA',
        email_domain: '@expressomercurio.com.br', taxpayer_number: 'a4406950001202',
        status: 'active'
      )
      expect(carrier).not_to be_valid
    end

    it 'falso quando _taxpayer_number_ já tiver sido cadastrado' do
      carrier1 = Carrier.create!(
        brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTDA',
        email_domain: '@expressomercurio.com.br', taxpayer_number: '04406950001202',
        status: 'active'
      )

      carrier2 = Carrier.new(
        brand_name: 'Expresso Hermes', corporate_name: 'Expresso hermes LTDA',
        email_domain: '@expressohermes.com.br', taxpayer_number: '4406950001202',
        status: 'active'
      )
      expect(carrier2).not_to be_valid
    end

    it 'falso quando _email_domain_ já tiver sido cadastrado' do
      carrier1 = Carrier.create!(
        brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTDA',
        email_domain: '@expressomercurio.com.br', taxpayer_number: '04406950001202',
        status: 'active'
      )

      carrier2 = Carrier.new(
        brand_name: 'Expresso Hermes', corporate_name: 'Expresso hermes LTDA',
        email_domain: '@expressomercurio.com.br', taxpayer_number: '4506950001202',
        status: 'active'
      )
      expect(carrier2).not_to be_valid
    end
  end
end
