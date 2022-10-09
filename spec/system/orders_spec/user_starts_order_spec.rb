require 'rails_helper'

describe 'Usuário inicia ordem de serviço' do
    it 'e acessa página com formulario para iniciar ordem de serviço' do
      # Arrange
      user = FactoryBot.create(:user)
      order = FactoryBot.create(:order, status: :pending)

      # Act
      login_as(user)
      visit orders_path
      click_on order.code
      click_on 'Iniciar Ordem de Serviço'
      # Assert
      expect(page).to have_field 'Opções de Entrega'
      expect(page).to have_button 'Iniciar Ordem de Serviço'


    end
    it 'com sucesso' do
      # Arrange
      user = FactoryBot.create(:user)
      order = FactoryBot.create(:order, status: :pending)
      delivery = FactoryBot.create(:transport_mode, status: :active)
      vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :circulation)

      # Act
      login_as(user)
      visit orders_path
      click_on order.code
      click_on 'Iniciar Ordem de Serviço'
      select delivery.with_weight_range, :from => 'Opções de Entrega'
      click_on 'Iniciar Ordem de Serviço'

      # Assert
      expect(page).to have_content 'Status: Aguardando Confirmação'
      expect(page).to have_content 'Ordem de Serviço Iniciada.'
      expect(page).to have_content delivery.name
      expect(page).to have_content vehicle.full_description
      expect(page).to have_content 'Valor do Frete:'
      expect(page).to have_content 'Prazo de entrega:'
    end
    it 'e encontra erro quando não há veículos em circulação' do
      # Arrange
      user = FactoryBot.create(:user)
      order = FactoryBot.create(:order, status: :pending)
      delivery = FactoryBot.create(:transport_mode, status: :active)
      vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :maintenance)

      # Act
      login_as(user)
      visit orders_path
      click_on order.code
      click_on 'Iniciar Ordem de Serviço'
      select delivery.with_weight_range, :from => 'Opções de Entrega'
      click_on 'Iniciar Ordem de Serviço'

      # Assert
      expect(page).to have_content 'Veículo não pode ficar em branco'
    end

    it 'e confirma o pedido com sucesso' do
      # Arrange
      user = FactoryBot.create(:user)
      order = FactoryBot.create(:order, status: :pending, weight: 50)
      delivery = FactoryBot.create(:transport_mode, min_weight: 1, max_weight: 100, status: :active)
      vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :circulation)

      # Act
      login_as(user)
      visit orders_path
      click_on order.code
      click_on 'Iniciar Ordem de Serviço'
      select delivery.with_weight_range, :from => 'Opções de Entrega'
      click_on 'Iniciar Ordem de Serviço'
      click_on 'Confirmar Ordem de Serviço'

      # Assert
      expect(page).to have_content "Ordem de Serviço confirmada."
      expect(page).to have_content "Status: Em Processo de Entrega"
      expect(Vehicle.find(1).status).to eq "out_for_delivery"

    end

    it 'e desconfirma o pedido com sucesso' do
      # Arrange
      user = FactoryBot.create(:user)
      order = FactoryBot.create(:order, status: :pending, weight: 50)
      delivery = FactoryBot.create(:transport_mode, min_weight: 1, max_weight: 100, status: :active)
      vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :circulation)

      # Act
      login_as(user)
      visit orders_path
      click_on order.code
      click_on 'Iniciar Ordem de Serviço'
      select delivery.with_weight_range, :from => 'Opções de Entrega'
      click_on 'Iniciar Ordem de Serviço'
      click_on 'Reconfigurar Ordem de Serviço'

      # Assert
      expect(page).to have_content "Inicie novamente a Ordem de Serviço."
      expect(page).to have_content "Status: Pendente"

    end
  end
