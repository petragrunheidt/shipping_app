require 'rails_helper'

RSpec.describe OrderStart, type: :model do
  describe 'generates shipping fee and delivery deadline' do
    it 'check calculations with mid range values' do
      # Arrange
      delivery = FactoryBot.create(:transport_mode, status: :active, fixed_rate: 15, min_weight: 10, max_weight: 200, min_distance: 10, max_distance: 200)
      vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :available)
      FactoryBot.create(:weight_table, transport_mode: delivery, min:20, max: 40, value: 1)
      FactoryBot.create(:distance_table, transport_mode: delivery, min:20, max: 40, value: 10)
      FactoryBot.create(:deadline, transport_mode: delivery, min:20, max: 40, time: 48)
      order = FactoryBot.create(:order, status: :on_route, weight: 30, total_distance: 30 )
      started_order = FactoryBot.create(:order_start, order: order, transport_mode: delivery, vehicle: vehicle, order_date: Date.today)
      # Act
      shipping_calculation = (started_order.shipping_fee == 15 + (30*1) + 10)
      deadline_calculation = (started_order.delivery_deadline == Date.today + (48 / 24).ceil)
      # Assert
      expect(shipping_calculation).to be true
      expect(deadline_calculation).to be true
    end
    it 'check calculations with min values' do
      # Arrange
      delivery = FactoryBot.create(:transport_mode, status: :active, fixed_rate: 15, min_weight: 10, max_weight: 200, min_distance: 10, max_distance: 200)
      vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :available)
      FactoryBot.create(:weight_table, transport_mode: delivery, min:10, max: 30, value: 1)
      FactoryBot.create(:distance_table, transport_mode: delivery, min:10, max: 30, value: 10)
      FactoryBot.create(:deadline, transport_mode: delivery, min:10, max: 30, time: 48)
      order = FactoryBot.create(:order, status: :on_route, weight: 10, total_distance: 10 )
      started_order = FactoryBot.create(:order_start, order: order, transport_mode: delivery, vehicle: vehicle, order_date: Date.today)
      # Act
      shipping_calculation = (started_order.shipping_fee == 15 + (10*1) + 10)
      deadline_calculation = (started_order.delivery_deadline == Date.today + (48 / 24).ceil)
      # Assert
      expect(shipping_calculation).to be true
      expect(deadline_calculation).to be true
    end
    it 'check calculations with max values' do
      # Arrange
      delivery = FactoryBot.create(:transport_mode, status: :active, fixed_rate: 15, min_weight: 10, max_weight: 200, min_distance: 10, max_distance: 200)
      vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :available)
      FactoryBot.create(:weight_table, transport_mode: delivery, min:10, max: 30, value: 1)
      FactoryBot.create(:distance_table, transport_mode: delivery, min:10, max: 30, value: 10)
      FactoryBot.create(:deadline, transport_mode: delivery, min:10, max: 30, time: 48)
      order = FactoryBot.create(:order, status: :on_route, weight: 30, total_distance: 30 )
      started_order = FactoryBot.create(:order_start, order: order, transport_mode: delivery, vehicle: vehicle, order_date: Date.today)
      # Act
      shipping_calculation = (started_order.shipping_fee == 15 + (30*1) + 10)
      deadline_calculation = (started_order.delivery_deadline == Date.today + (48 / 24).ceil)
      # Assert
      expect(shipping_calculation).to be true
      expect(deadline_calculation).to be true
    end
  end
end
