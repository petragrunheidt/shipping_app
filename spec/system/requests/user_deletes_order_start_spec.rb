require 'rails_helper'

describe 'Usuário tenta deletar order_start' do
  it 'após o pedido ter sido finalizado' do
    # Arrange
    user = FactoryBot.create(:user)
    order = FactoryBot.create(:order)
    order_start = FactoryBot.create(:order_start, order: order)
    order_end = FactoryBot.create(:order_end, order: order)

    login_as(user)
    delete('/orders/1/order_starts/1')

    expect(response).to redirect_to(root_path)
  end
end
