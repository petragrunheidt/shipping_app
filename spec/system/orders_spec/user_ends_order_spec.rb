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
      expect(page).to have_field 'Motivo do Atraso'
      expect(page).to have_button 'Finalizar Ordem de Serviço'

    end
    it 'com sucesso e sem atraso' do
      # Arrange
      delivery = FactoryBot.create(:transport_mode, status: :active)
      deadline_table = FactoryBot.create(:deadline, min: 10, max: 100, time: 72, transport_mode: delivery)
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
      click_on 'Finalizar Ordem de Serviço'

      # Assert
      expect(page).to have_content 'Status: Entregue (no prazo)'
      expect(page).to have_content 'Ordem de Serviço Finalizada.'
      expect(page).to have_content delivery.name
      expect(page).to have_content vehicle.full_description
      expect(page).to have_content 'Valor do Frete:'
      expect(page).to have_content "Pedido entregue em: #{I18n.localize(Date.today)}"
      expect(Vehicle.find(1).status).to eq "available"
    end
    it 'e encontra erro ao tentar cadastrar motivo em finalização sem atraso' do
      # Arrange
      delivery = FactoryBot.create(:transport_mode, status: :active)
      deadline_table = FactoryBot.create(:deadline, min: 10, max: 100, time: 72, transport_mode: delivery)
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
      fill_in 'Motivo do Atraso', with: 'Motivo'
      click_on 'Finalizar Ordem de Serviço'

      # Assert
      expect(page).to have_content 'Motivo do Atraso deve ficar em branco pois não há atraso'
    end
    it 'com sucesso e com atraso' do
      # Arrange
      delivery = FactoryBot.create(:transport_mode, status: :active)
      vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :out_for_delivery)
      deadline_table = FactoryBot.create(:deadline, min: 10, max: 100, time: 24, transport_mode: delivery)
      user = FactoryBot.create(:user)
      order = FactoryBot.create(:order, status: :on_route)
      started_order = FactoryBot.create(:order_start, order: order, transport_mode: delivery, vehicle: vehicle, order_date: Date.yesterday - 1)

      # Act
      login_as(user)
      visit orders_path
      click_on started_order.order.code
      click_on 'Finalizar Ordem de Serviço'
      fill_in 'Data de Entrega', with: Date.today
      fill_in 'Motivo do Atraso', with: 'Namorada da entregadora sonhou que as duas haviam terminado e ela precisou do dia de folga.'
      click_on 'Finalizar Ordem de Serviço'

      # Assert
      expect(page).to have_content 'Status: Entregue (com atraso)'
      expect(page).to have_content 'Ordem de Serviço Finalizada.'
      expect(page).to have_content delivery.name
      expect(page).to have_content vehicle.full_description
      expect(page).to have_content 'Valor do Frete:'
      expect(page).to have_content "Pedido entregue em: #{I18n.localize(Date.today)}"
      expect(page).to have_content 'Namorada da entregadora sonhou que as duas haviam terminado e ela precisou do dia de folga.'
    end
    it 'e encontra erro ao tentar fazer cadastro com data em branco' do
      # Arrange
      delivery = FactoryBot.create(:transport_mode, status: :active)
      vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :out_for_delivery)
      user = FactoryBot.create(:user)
      deadline_table = FactoryBot.create(:deadline, min: 10, max: 100, time: 24, transport_mode: delivery)
      order = FactoryBot.create(:order, status: :on_route)
      started_order = FactoryBot.create(:order_start, order: order, transport_mode: delivery, vehicle: vehicle, order_date: Date.yesterday - 1)

      # Act
      login_as(user)
      visit orders_path
      click_on started_order.order.code
      click_on 'Finalizar Ordem de Serviço'
      fill_in 'Data de Entrega', with: ''
      click_on 'Finalizar Ordem de Serviço'

      # Assert
      expect(page).to have_content 'Data de Entrega não pode ficar em branco'
    end
    it 'e encontra erro ao tentar fazer cadastro com atraso sem motivo de atraso' do
      # Arrange
      delivery = FactoryBot.create(:transport_mode, status: :active)
      vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :out_for_delivery)
      user = FactoryBot.create(:user)
      deadline_table = FactoryBot.create(:deadline, min: 10, max: 100, time: 24, transport_mode: delivery)
      order = FactoryBot.create(:order, status: :on_route)
      started_order = FactoryBot.create(:order_start, order: order, transport_mode: delivery, vehicle: vehicle, order_date: Date.yesterday - 1)

      # Act
      login_as(user)
      visit orders_path
      click_on started_order.order.code
      click_on 'Finalizar Ordem de Serviço'
      fill_in 'Data de Entrega', with: Date.today
      click_on 'Finalizar Ordem de Serviço'

      # Assert
      expect(page).to have_content 'Motivo do Atraso não pode ficar em branco pois houve atraso.'
    end
end
