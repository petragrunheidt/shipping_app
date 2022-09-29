require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context'presence' do
      it 'false when name is empty' do
        # Arrange
        FactoryBot.create(:user)

        # Act

        # Assert
        
      end
    end
  end
end
