require 'rails_helper'

RSpec.describe DistanceTable, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when min is empty' do
        # Arrange
        dt = FactoryBot.build(:distance_table, min: '')

        # Act
        result = dt.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when max is empty' do
        # Arrange
        dt = FactoryBot.build(:distance_table, max: '')

        # Act
        result = dt.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when value is empty' do
        # Arrange
        dt = FactoryBot.build(:distance_table, value: '')

        # Act
        result = dt.valid?

        # Assert
        expect(result).to be false

      end
    end
    context 'comparison' do
      it 'false when max is less than min' do
        # Arrange
        dt = FactoryBot.build(:distance_table, min: 10, max: 5)

        # Act
        result = dt.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when min is less than transport_mode min_distance' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, min_distance: 10)
        dt = FactoryBot.build(:distance_table, min: 5, transport_mode: tm)

        # Act
        result = dt.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when max is greater than transport_mode max_distance' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, max_distance: 100)
        dt = FactoryBot.build(:distance_table, max: 200, transport_mode: tm)

        # Act
        result = dt.valid?

        # Assert
        expect(result).to be false
      end
      it 'false when min is less than last table input max' do
        tm = FactoryBot.create(:transport_mode, min_distance: 10, max_distance: 100)
        dl1 = FactoryBot.create(:distance_table, min: 10, max: 30, transport_mode: tm)
        dl2 = FactoryBot.build(:distance_table, min: 20, max: 50, transport_mode: tm)
        
        result = dl2.valid?

        expect(result).to be false
      end
    end
  end
end
