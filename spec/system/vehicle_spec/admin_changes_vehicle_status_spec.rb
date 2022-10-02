require 'rails_helper'

describe 'Admin tenta mudar o status de ativação de um veículo' do
    it 'e não encontra botão se entra como usuário comum' do
      # Arrange
      admin = FactoryBot.create(:user)
      FactoryBot.create(:vehicle, nameplate: 'ABC1234', vehicle_brand: 'Nissan',
         vehicle_model: 'A140i')

      # Act
      login_as(admin)
      visit vehicles_path
      click_on('Nissan A140i - ABC1234')


      # Assert
      expect(page).not_to have_button 'Mandar Veículo para manutenção'
      expect(page).not_to have_button 'Mandar Veículo para circulação'

    end
    it 'do padrão (em manutenção), para em circulação (com sucesso)' do
        # Arrange
        admin = FactoryBot.create(:user, admin: true)
        FactoryBot.create(:vehicle, nameplate: 'ABC1234', vehicle_brand: 'Nissan',
           vehicle_model: 'A140i', status: 0)

        # Act
        login_as(admin)
        visit vehicles_path
        click_on('Nissan A140i - ABC1234')
        click_on('Mandar Veículo para circulação')

        # Assert
        expect(page).to have_button 'Mandar Veículo para manutenção'
        expect(page).to have_content 'Em circulação'
        expect(page).to have_content 'Veículo ativado para circulação.'
    end
    it 'de ativo, para inativo (com sucesso)' do
      # Arrange
      admin = FactoryBot.create(:user, admin: true)
      FactoryBot.create(:vehicle, nameplate: 'ABC1234', vehicle_brand: 'Nissan',
         vehicle_model: 'A140i', status: 1)

      # Act
      login_as(admin)
      visit vehicles_path
      click_on('Nissan A140i - ABC1234')
      click_on('Mandar Veículo para manutenção')

      # Assert
      expect(page).to have_button 'Mandar Veículo para circulação'
      expect(page).to have_content 'Em manutenção'
      expect(page).to have_content 'Veículo enviado para manutenção.'
  end
end
