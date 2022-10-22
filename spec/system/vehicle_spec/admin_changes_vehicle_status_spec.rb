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
   it 'do padrão (em manutenção), para Disponível (com sucesso)' do
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
        expect(page).to have_content 'Disponível'
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
      expect(page).to have_content 'Manutenção'
      expect(page).to have_content 'Veículo enviado para manutenção.'
   end
   it 'e não encontra botão quando o Veículo está em entrega' do
      admin = FactoryBot.create(:user, admin: true)
      vehicle = FactoryBot.create(:vehicle, status: :out_for_delivery)

      login_as(admin)
      visit vehicles_path
      click_on(vehicle.full_description)

      expect(page).not_to have_button 'Mandar Veículo para circulação'
      expect(page).not_to have_button 'Mandar Veículo para manutenção'
      expect(page).to have_content 'Em Processo de Entrega'
   end
end
