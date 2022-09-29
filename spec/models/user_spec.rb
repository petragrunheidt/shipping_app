require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        # Arrange
        user = FactoryBot.build(:user, name: '')

        # Act
        result = user.valid?

        # Assert
        expect(result).to be false

      end
    end
    context 'format' do
      it 'false when email doesnt end with @sistemadefrete.com.br' do
        # Arrange
        user = FactoryBot.build(:user, email: 'petra@mail.com.br')

        # Act
        result = user.valid?

        # Assert
        expect(result).to be false

      end
    end
  end
end
