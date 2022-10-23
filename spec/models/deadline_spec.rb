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
      
    end
    context 'comparison' do
      it 'false when max is less than min' do
        # Arrange
        dl = FactoryBot.build(:deadline, min: 10, max: 5)

        # Act
        result = dl.valid?

        # Assert
        expect(result).to be false
      end
      it 'false when min is equal to zero' do
        # Arrange
        dl = FactoryBot.build(:deadline, min: 0, max: 50)

        # Act
        result = dl.valid?

        # Assert
        expect(result).to be false
      end
      it 'false when min is less than zero' do
        # Arrange
        dl = FactoryBot.build(:deadline, min: -1, max: 50)

        # Act
        result = dl.valid?

        # Assert
        expect(result).to be false
      end

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
      it 'false when min is less than last table input max' do
        tm = FactoryBot.create(:transport_mode, min_distance: 10, max_distance: 100)
        dl1 = FactoryBot.create(:deadline, min: 10, max: 30, transport_mode: tm)
        dl2 = FactoryBot.build(:deadline, min: 20, max: 50, transport_mode: tm)
        
        result = dl2.valid?

        expect(result).to be false
      end
      it 'false when min is equal to last table input max' do
        tm = FactoryBot.create(:transport_mode, min_distance: 10, max_distance: 100)
        dl1 = FactoryBot.create(:deadline, min: 10, max: 30, transport_mode: tm)
        dl2 = FactoryBot.build(:deadline, min: 30, max: 50, transport_mode: tm)
        
        result = dl2.valid?

        expect(result).to be false
      end
    end
  end
end
