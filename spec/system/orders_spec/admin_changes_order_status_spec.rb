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

    it 'com sucesso' do
      # Arrange
      admin = FactoryBot.create(:user, admin: true)
      order = FactoryBot.create(:order, status: :on_route)

      # Act
      login_as(admin)
      visit orders_path
      click_on order.code
      click_on 'Marcar como Cancelada'

      # Assert
      expect(page).to have_content 'Status: Cancelada'
      expect(page).to have_content 'Status da ordem de serviço atualizada.'
  end
end
