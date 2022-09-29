require 'rails_helper'

describe 'Admin tenta mudar o status de ativação de um modo de transporte' do
    it 'e não encontra botão se entra como usuário comum' do
      # Arrange
      admin = FactoryBot.create(:user)
      FactoryBot.create(:transport_mode, status: 0)

      # Act
      login_as(admin)
      visit transport_modes_path
      click_on('mais informações')


      # Assert
      expect(page).not_to have_button 'Desativar'
      expect(page).not_to have_button 'Ativar'

    end
    it 'do padrão (inativo), para ativo (com sucesso)' do
        # Arrange
        admin = FactoryBot.create(:user, admin: true)
        FactoryBot.create(:transport_mode, status: 0)

        # Act
        login_as(admin)
        visit transport_modes_path
        click_on('mais informações')
        click_on('Ativar')

        # Assert
        expect(page).to have_button 'Desativar'
        expect(page).to have_content 'Ativo'
        expect(page).to have_content 'Modo de Transporte ativado.'
    end
    it 'de ativo, para inativo (com sucesso)' do
      # Arrange
      admin = FactoryBot.create(:user, admin: true)
      FactoryBot.create(:transport_mode, status: 1)

      # Act
      login_as(admin)
      visit transport_modes_path
      click_on('mais informações')
      click_on('Desativar')

      # Assert
      expect(page).to have_button 'Ativar'
      expect(page).to have_content 'Inativo'
      expect(page).to have_content 'Modo de Transporte desativado.'
  end
end
