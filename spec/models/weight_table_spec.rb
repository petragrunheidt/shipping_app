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
      it 'false when min is less than last table input max' do
        tm = FactoryBot.create(:transport_mode, min_weight: 10, max_weight: 100)
        dl1 = FactoryBot.create(:weight_table, min: 10, max: 30, transport_mode: tm)
        dl2 = FactoryBot.build(:weight_table, min: 20, max: 50, transport_mode: tm)
        
        result = dl2.valid?

        expect(result).to be false
      end
    end
  end
end
