require 'rails_helper'

describe 'Usuário iniciar ordem de serviço' do
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
      delivery = FactoryBot.create(:transport_mode)

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
      expect(page).to have_content 'Valor do Frete:'
      expect(page).to have_content 'Prazo de entrega:'
    end
  end
