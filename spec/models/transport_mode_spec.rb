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
      it 'false when fixed_rate is empty' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, fixed_rate: '')

        # Act
        result = tm.valid?

        # Assert
        expect(result).to be false

      end
    end
    context '#comparison' do
      it 'false when min_weight is equal to 0' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, min_weight: 0)

        # Act
        result = tm.valid?

        # Assert
        expect(result).to be false
      end
      it 'false when min_weight is negative' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, min_weight: -1)

        # Act
        result = tm.valid?

        # Assert
        expect(result).to be false
      end
      it 'false when min_distance is equal to 0' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, min_distance: 0)

        # Act
        result = tm.valid?

        # Assert
        expect(result).to be false
      end
      it 'false when min_distance is negative' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, min_distance: -1)

        # Act
        result = tm.valid?

        # Assert
        expect(result).to be false
      end
      it 'false when fixed_rate is equal to 0' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, fixed_rate: 0)

        # Act
        result = tm.valid?

        # Assert
        expect(result).to be false
      end
      it 'false when fixed_rate is negative' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, fixed_rate: -1)

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
