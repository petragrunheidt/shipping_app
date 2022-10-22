require 'rails_helper'

describe 'Usuário vê veículos cadastrados' do
    it 'na pagina de veículos (em forma de lista)' do
        # Arrange
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode)
        Vehicle.create(nameplate: 'ABC1234', vehicle_brand: 'Nissan', vehicle_model: 'A140i',
           manifacture_year: 2005, maximum_load: 100, transport_mode: trans)

        # Act
        login_as(user)
        visit root_path
        click_on('Veículos')

        # Assert
        expect(page).to have_content('Veículos disponíveis:')
        expect(page).to have_link('Nissan A140i - ABC1234')
        expect(page).to have_content 'Manutenção'

    end
    it 'e vê mensagem quando não há veículos cadastrados' do
      # Arrange
      user = FactoryBot.create(:user)

      # Act
      login_as(user)
      visit root_path
      click_on('Veículos')

      # Assert
      expect(page).to have_content('Veículos disponíveis:')
      expect(page).to have_content('Nenhum Veículo disponível')


    end
    it 'e vê mais detalhes de um veículo' do
        # Arrange
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode, name: 'Modal Rodoviário')
        Vehicle.create(nameplate: 'ABC1234', vehicle_brand: 'Nissan', vehicle_model: 'A140i',
          manifacture_year: 2005, maximum_load: 100, transport_mode: trans)

        # Act
        login_as(user)
        visit vehicles_path
        click_on('Nissan A140i - ABC1234')

        # Assert
        expect(page).to have_content 'Nissan A140i - ABC1234'
        expect(page).to have_content 'Ano de Fabricação: 2005'
        expect(page).to have_content 'Carga máxima: 100kg'
        expect(page).to have_link 'Modal Rodoviário'
        expect(page).to have_content 'Manutenção'

    end
    it 'e volta para a lista de veículos' do
      # Arrange
      user = FactoryBot.create(:user)
      FactoryBot.create(:vehicle, nameplate: 'ABC1234', vehicle_brand: 'Nissan', vehicle_model: 'A140i')

      # Act
      login_as(user)
      visit vehicles_path
      click_on('Nissan A140i - ABC1234')
      click_on('Voltar')
      # Assert
      expect(current_path).to eq vehicles_path
    end
end
