require 'rails_helper'

RSpec.describe Deadline, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when min is empty' do
        # Arrange
        dl = FactoryBot.build(:deadline, min: '')

        # Act
        result = dl.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when max is empty' do
        # Arrange
        dl = FactoryBot.build(:deadline, max: '')

        # Act
        result = dl.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when time is empty' do
        # Arrange
        dl = FactoryBot.build(:deadline, time: '')

        # Act
        result = dl.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when transport_mode is empty' do
        # Arrange
        dl = FactoryBot.build(:deadline, transport_mode: nil)

        # Act
        result = dl.valid?

        # Assert
        expect(result).to be false

      end
    end
    context 'comparison' do
      it 'false when min is less than transport_mode min_distance' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, min_distance: 10)
        dl = FactoryBot.build(:deadline, min: 5, transport_mode: tm)

        # Act
        result = dl.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when max is greater than transport_mode max_distance' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, max_distance: 100)
        dl = FactoryBot.build(:deadline, max: 200, transport_mode: tm)

        # Act
        result = dl.valid?

        # Assert
        expect(result).to be false
      end
    end
  end
end
