require 'rails_helper'

RSpec.describe WeightTable, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when min is empty' do
        # Arrange
        wt = FactoryBot.build(:weight_table, min: '')

        # Act
        result = wt.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when max is empty' do
        # Arrange
        wt = FactoryBot.build(:weight_table, max: '')

        # Act
        result = wt.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when value is empty' do
        # Arrange
        wt = FactoryBot.build(:weight_table, value: '')

        # Act
        result = wt.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when transport_mode is empty' do
        # Arrange
        wt = FactoryBot.build(:weight_table, transport_mode: nil)

        # Act
        result = wt.valid?

        # Assert
        expect(result).to be false

      end
    end
    context 'comparison' do
      it 'false when min is less than transport_mode min_weight' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, min_weight: 10)
        wt = FactoryBot.build(:weight_table, min: 5, transport_mode: tm)

        # Act
        result = wt.valid?

        # Assert
        expect(result).to be false

      end
      it 'false when max is greater than transport_mode max_weight' do
        # Arrange
        tm = FactoryBot.build(:transport_mode, max_weight: 100)
        wt = FactoryBot.build(:weight_table, max: 200, transport_mode: tm)

        # Act
        result = wt.valid?

        # Assert
        expect(result).to be false
      end
    end
  end
end
