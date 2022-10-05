require 'rails_helper'

describe 'Admin tenta mudar o status de ativação de um veículo' do
    it 'e não encontra botão se entra como usuário comum' do
      # Arrange
      user = FactoryBot.create(:user)
      order = FactoryBot.create(:order)

      # Act
      login_as(user)
      visit orders_path
      click_on order.code



      # Assert
      expect(page).not_to have_button 'Marcar como Pendente'
      expect(page).not_to have_button 'Marcar como Cancelado'
      expect(page).not_to have_button 'Marcar como Entregue'

    end
    it 'do padrão (pendente), para em entregue (com sucesso)' do
        # Arrange
        admin = FactoryBot.create(:user, admin: true)
        order = FactoryBot.create(:order)

        # Act
        login_as(admin)
        visit orders_path
        click_on order.code
        click_on 'Marcar como Entregue'

        # Assert
        expect(page).to have_content 'Status: Entregue'
        expect(page).to have_content 'Status da ordem de serviço atualizada.'
    end
    it 'de cancelada, para entregue' do
      # Arrange
      admin = FactoryBot.create(:user, admin: true)
      order = FactoryBot.create(:order, status: 5)

      # Act
      login_as(admin)
      visit orders_path
      click_on order.code
      click_on 'Marcar como Pendente'

      # Assert
      expect(page).to have_content 'Status: Pendente'
      expect(page).to have_content 'Status da ordem de serviço atualizada.'
  end
end
