require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'must have a delivery_address' do
      # Arrange
      order = FactoryBot.build(:order, delivery_address: '')
      # Act
      result = order.valid?
      # Assert
      expect(order.errors.include? :delivery_address).to be true
    end
    it 'must have a takeout_address' do
      # Arrange
      order = FactoryBot.build(:order, takeout_address: '')

      # Act
      order.valid?
      # Assert
      expect(order.errors.include? :takeout_address).to be true
    end
    it 'customer_id must have length of 14' do
    order = FactoryBot.build(:order, customer_id: '9301')

    result = order.valid?

    expect(order.errors.include? :customer_id).to be true
    end
    it 'customer_id must have have only numeric characters' do
      order = FactoryBot.build(:order, customer_id: 'ADKEODKAMOQNDT')

      result = order.valid?

      expect(order.errors.include? :customer_id).to be true
    end
  end
  describe 'generates a random code' do
    it 'when creating a new order' do
      # Arrange
      order = FactoryBot.create(:order)
      # Act

      # Assert
      expect(order.code).not_to be_empty
      expect(order.code.length).to eq 15
    end
    it 'and the code is unique' do
      # Arrange
      order1 = FactoryBot.create(:order)
      order2 = FactoryBot.create(:order)
      # Act
      order2.code = order1.code
      result = order2.save

      # Assert
      expect(result).to eq false
    end
    it 'and must not be modified' do
      # Arrange
      order = FactoryBot.create(:order)
      original_code = order.code

      # Act
      order.update!(name: 'Mimi')

      # Assert
      expect(order.code).to eq original_code

    end
  end
end
