require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    context 'preseça' do
      it 'falso quando _model_ for vazio' do
        # Arrange
        Carrier.new(
          brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTDA',
          email_domain: 'expressomercurio.com.br', taxpayer_number: '00440695000122',
          status: 'active'
        )

        vehicle = Vehicle.new(
          model: '', year: '2019', brand: 'Volvo', license_plate: 'tyr9865', carrier_id: '1'
        )
        # Act and Assert
        expect(vehicle).not_to be_valid
      end

      it 'falso quando _year_ for vazio' do
        # Arrange
        Carrier.new(
          brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTDA',
          email_domain: 'expressomercurio.com.br', taxpayer_number: '00440695000122',
          status: 'active'
        )

        vehicle = Vehicle.new(
          model: 'Trucker 7000', year: '', brand: 'Volvo', license_plate: 'tyr9865', carrier_id: '1'
        )
        # Act and Assert
        expect(vehicle).not_to be_valid
      end

      it 'falso quando _brand_ for vazio' do
        # Arrange
        Carrier.new(
          brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTDA',
          email_domain: 'expressomercurio.com.br', taxpayer_number: '00440695000122',
          status: 'active'
        )

        vehicle = Vehicle.new(
          model: 'Trucker 7000', year: '2019', brand: '', license_plate: 'tyr9865', carrier_id: '1'
        )
        # Act and Assert
        expect(vehicle).not_to be_valid
      end

      it 'falso quando _license_plate_ for vazio' do
        # Arrange
        Carrier.new(
          brand_name: 'Expresso Mercúrio', corporate_name: 'Expresso Mercúrio LTDA',
          email_domain: 'expressomercurio.com.br', taxpayer_number: '00440695000122',
          status: 'active'
        )

        vehicle = Vehicle.new(
          model: 'Trucker 7000', year: '2019', brand: 'Volvo', license_plate: '', carrier_id: '1'
        )
        # Act and Assert
        expect(vehicle).not_to be_valid
      end
    end
  end
end
