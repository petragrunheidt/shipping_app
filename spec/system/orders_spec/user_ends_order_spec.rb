require 'rails_helper'

describe 'Usuário finaliza ordem de serviço' do
    it 'e acessa página com formulario para finalizar ordem de serviço' do
      # Arrange
      user = FactoryBot.create(:user)
      order = FactoryBot.create(:order, status: :on_route)
      started_order = FactoryBot.create(:order_start, order: order)

      # Act
      login_as(user)
      visit orders_path
      click_on started_order.order.code
      click_on 'Finalizar Ordem de Serviço'
      # Assert
      expect(page).to have_field 'Data de Entrega'
      #expect(page).to have_field 'Entrega dentro do prazo?'
      expect(page).to have_field 'Motivo do Atraso'
      expect(page).to have_button 'Finalizar Ordem de Serviço'


    end
    it 'com sucesso e sem atraso' do
      # Arrange
      delivery = FactoryBot.create(:transport_mode, status: :active)
      vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :out_for_delivery)
      user = FactoryBot.create(:user)
      order = FactoryBot.create(:order, status: :on_route)
      started_order = FactoryBot.create(:order_start, order: order, transport_mode: delivery, vehicle: vehicle)


      # Act
      login_as(user)
      visit orders_path
      click_on started_order.order.code
      click_on 'Finalizar Ordem de Serviço'
      fill_in 'Data de Entrega', with: Date.today
      #select "Sim", :from => 'Entrega dentro do prazo?'
      click_on 'Finalizar Ordem de Serviço'

      # Assert
      expect(page).to have_content 'Status: Entregue (no prazo)'
      expect(page).to have_content 'Ordem de Serviço Finalizada.'
      expect(page).to have_content delivery.name
      expect(page).to have_content vehicle.full_description
      expect(page).to have_content 'Valor do Frete:'
      expect(page).to have_content 'Data Prevista de Entrega:'
      expect(page).to have_content "Pedido entregue em #{I18n.localize(Date.today)}"
      expect(Vehicle.find(1).status).to eq "available"
    end
    it 'com sucesso e com atraso' do
      # Arrange
      delivery = FactoryBot.create(:transport_mode, status: :active)
      vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :out_for_delivery)
      user = FactoryBot.create(:user)
      order = FactoryBot.create(:order, status: :on_route)
      started_order = FactoryBot.create(:order_start, order: order, transport_mode: delivery, vehicle: vehicle)

      # Act
      login_as(user)
      visit orders_path
      click_on started_order.order.code
      click_on 'Finalizar Ordem de Serviço'
      fill_in 'Data de Entrega', with: Date.yesterday
      #select "Não", :from => 'Entrega dentro do prazo?'
      fill_in 'Motivo do Atraso', with: 'Namorada da entregadora sonhou que as duas haviam terminado e ela precisou do dia de folga.'
      click_on 'Finalizar Ordem de Serviço'

      # Assert
      expect(page).to have_content 'Status: Entregue (com atraso)'
      expect(page).to have_content 'Ordem de Serviço Finalizada.'
      expect(page).to have_content delivery.name
      expect(page).to have_content vehicle.full_description
      expect(page).to have_content 'Valor do Frete:'
      expect(page).to have_content 'Data Prevista de Entrega:'
      expect(page).to have_content "Pedido entregue em #{I18n.localize(Date.yesterday)}"
      expect(page).to have_content 'Namorada da entregadora sonhou que as duas haviam terminado e ela precisou do dia de folga.'
    end

  #   it 'e encontra erro quando não há veículo Disponível' do
  #     # Arrange
  #     user = FactoryBot.create(:user)
  #     order = FactoryBot.create(:order, status: :pending)
  #     delivery = FactoryBot.create(:transport_mode, status: :active)
  #     vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :maintenance)

  #     # Act
  #     login_as(user)
  #     visit orders_path
  #     click_on order.code
  #     click_on 'Finalizar Ordem de Serviço'

  #     # Assert
  #     expect(page).to have_content 'No momento, não há Veículos disponíveis para essa Ordem de Serviço'
  #   end

  #   it 'e confirma o pedido com sucesso' do
  #     # Arrange
  #     user = FactoryBot.create(:user)
  #     order = FactoryBot.create(:order, status: :pending, weight: 50)
  #     delivery = FactoryBot.create(:transport_mode, min_weight: 1, max_weight: 100, status: :active)
  #     vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :available)

  #     # Act
  #     login_as(user)
  #     visit orders_path
  #     click_on order.code
  #     click_on 'Finalizar Ordem de Serviço'
  #     select delivery.with_weight_range, :from => 'Opções de Entrega'
  #     click_on 'Finalizar Ordem de Serviço'
  #     click_on 'Confirmar Ordem de Serviço'

  #     # Assert
  #     expect(page).to have_content "Ordem de Serviço confirmada."
  #     expect(page).to have_content "Status: Em Processo de Entrega"
  #     expect(Vehicle.find(1).status).to eq "out_for_delivery"

  #   end

  #   it 'e desconfirma o pedido com sucesso' do
  #     # Arrange
  #     user = FactoryBot.create(:user)
  #     order = FactoryBot.create(:order, status: :pending, weight: 50)
  #     delivery = FactoryBot.create(:transport_mode, min_weight: 1, max_weight: 100, status: :active)
  #     vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :available)

  #     # Act
  #     login_as(user)
  #     visit orders_path
  #     click_on order.code
  #     click_on 'Finalizar Ordem de Serviço'
  #     select delivery.with_weight_range, :from => 'Opções de Entrega'
  #     click_on 'Finalizar Ordem de Serviço'
  #     click_on 'Reconfigurar Ordem de Serviço'

  #     # Assert
  #     expect(page).to have_content "Inicie novamente a Ordem de Serviço."
  #     expect(page).to have_content "Status: Pendente"

  #   end
end
