require 'rails_helper'

RSpec.describe DistanceTable, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when min is empty' do
        # Arrange
        wt = FactoryBot.build(:distance_table, min: '')

        # Act
        result = wt.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when max is empty' do
        # Arrange
        wt = FactoryBot.build(:distance_table, max: '')

        # Act
        result = wt.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when value is empty' do
        # Arrange
        wt = FactoryBot.build(:distance_table, value: '')

        # Act
        result = wt.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when transport_mode is empty' do
        # Arrange
        wt = FactoryBot.build(:distance_table, transport_mode: nil)

        # Act
        result = wt.valid?

        # Assert
        expect(result).to be false

      end
    end
    context 'comparison' do
      it 'false when min is less than transport_mode min_distance' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, min_distance: 10)
        wt = FactoryBot.build(:distance_table, min: 5, transport_mode: tm)

        # Act
        result = wt.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when max is greater than transport_mode max_distance' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, max_distance: 100)
        wt = FactoryBot.build(:distance_table, max: 200, transport_mode: tm)

        # Act
        result = wt.valid?

        # Assert
        expect(result).to be false
      end
    end
  end
end
