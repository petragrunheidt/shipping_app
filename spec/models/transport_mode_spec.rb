require 'rails_helper'

RSpec.describe TransportMode, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, name: '')

        # Act
        result = tm.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when shipping_value is empty' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, shipping_value: '')

        # Act
        result = tm.valid?

        # Assert
        expect(result).to be false

      end
    end
    context '#comparison' do
      it 'false when min_weight is not greater than 0' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, min_weight: 0)

        # Act
        result = tm.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when min_distance is not greater than 0' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, min_distance: 0)

        # Act
        result = tm.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when shipping_value is not greater than 0' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, shipping_value: 0)

        # Act
        result = tm.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when max_weight is not greater than min_weight' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, max_weight: 1, min_weight: 10)

        # Act
        result = tm.valid?

        # Assert
        expect(result).to be false
      end
      it 'false when max_distance is not greater than min_distance' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, max_distance: 1, min_distance: 10)

        # Act
        result = tm.valid?

        # Assert
        expect(result).to be false
      end
    end
  end
end
