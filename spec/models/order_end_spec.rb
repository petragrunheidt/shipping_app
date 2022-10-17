require 'rails_helper'

RSpec.describe OrderEnd, type: :model do
  describe '#valid?' do
    it 'delivery date cant be before order_start date' do
      delivery = FactoryBot.create(:transport_mode, status: :active)
      vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :out_for_delivery)
      user = FactoryBot.create(:user)
      deadline_table = FactoryBot.create(:deadline, min: 10, max: 100, time: 24, transport_mode: delivery)
      order = FactoryBot.create(:order, status: :on_route)
      started_order = FactoryBot.create(:order_start, order: order, transport_mode: delivery, vehicle: vehicle, order_date: Date.yesterday - 1)
      order_end = FactoryBot.build(:order_end, order: order, time: Date.yesterday - 2, reason: '' )

      order_end.valid?

      expect(order_end.errors.include? :time).to be true
    end
    it 'delivery date cant be a future date' do
      delivery = FactoryBot.create(:transport_mode, status: :active)
      vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :out_for_delivery)
      user = FactoryBot.create(:user)
      deadline_table = FactoryBot.create(:deadline, min: 10, max: 100, time: 72, transport_mode: delivery)
      order = FactoryBot.create(:order, status: :on_route)
      started_order = FactoryBot.create(:order_start, order: order, transport_mode: delivery, vehicle: vehicle, order_date: Date.today)
      order_end = FactoryBot.build(:order_end, order: order, time: Date.tomorrow, reason: '' )

      order_end.valid?

      expect(order_end.errors.include? :time).to be true
    end
  end
end
