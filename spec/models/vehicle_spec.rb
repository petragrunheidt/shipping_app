require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        # Arrange
        vehicle = FactoryBot.build(:vehicle, nameplate: '')

        # Act
        result = vehicle.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when vehicle_model is empty' do
        # Arrange
        vehicle = FactoryBot.build(:vehicle, vehicle_model: '')

        # Act
        result = vehicle.valid?

        # Assert
        expect(result).to be false

      end
    end
    context '#comparison' do
      it 'false when maximum_load is not greater than 0' do
        # Arrange
        vehicle = FactoryBot.build(:vehicle, maximum_load: 0)

        # Act
        result = vehicle.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when maximum_load is greater than mode of transport max_weight' do
        # Arrange
        transport_mode = FactoryBot.create(:transport_mode, max_weight: 100)
        vehicle = FactoryBot.build(:vehicle, maximum_load: 101, transport_mode: transport_mode)

        # Act
        result = vehicle.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when maximum_load is not greater than mode of transport min_weight' do
        # Arrange
        transport_mode = FactoryBot.create(:transport_mode, min_weight: 20)
        vehicle = FactoryBot.build(:vehicle, maximum_load: 10, transport_mode: transport_mode)

        # Act
        result = vehicle.valid?

        # Assert
        expect(result).to be false
      end
    end
  end
end

