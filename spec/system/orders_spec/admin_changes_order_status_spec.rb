require 'rails_helper'

describe 'Admin tenta cancelar uma ordem de serviço' do
it 'e não encontra botão se entra como usuário comum' do
  # Arrange
  user = FactoryBot.create(:user)
  order = FactoryBot.create(:order, status: :on_route)

  # Act
  login_as(user)
  visit orders_path
  click_on order.code

  # Assert
  expect(page).not_to have_button 'Marcar como Cancelada'

end
  it 'com sucesso (ordem já iniciada)' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)
    order = FactoryBot.create(:order, status: :pending, weight: 50)
    delivery = FactoryBot.create(:transport_mode, min_weight: 1, max_weight: 100, min_distance: 1, max_distance: 100, status: :active)
    vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :available)

    # Act
    login_as(admin)
    visit orders_path
    click_on order.code
    click_on 'Iniciar Ordem de Serviço'
    fill_in 'Data do Pedido', with: Date.today
    select delivery.name, :from => 'Opções de Entrega'
    click_on 'Iniciar Ordem de Serviço'
    click_on 'Confirmar Ordem de Serviço'
    click_on 'Marcar como Cancelada'

    # Assert
    expect(page).to have_content 'Status: Cancelada'
    expect(page).to have_content 'Status da ordem de serviço atualizada.'
    expect(order.order_start.vehicle.status).to eq 'available'
  end
end
