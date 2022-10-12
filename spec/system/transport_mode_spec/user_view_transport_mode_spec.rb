require 'rails_helper'

describe 'Usuário vê modos de transporte cadastrados' do
    it 'na pagina de modos de transporte (em forma de lista)' do
        # Arrange
        user = FactoryBot.create(:user)
        TransportMode.create(name: 'Modal Rodoviário', min_distance: 10, max_distance: 100, min_weight: 10,
           max_weight: 100, fixed_rate: 10.00)

        # Act
        login_as(user)
        visit root_path
        click_on('Modos de Transporte')

        # Assert
        expect(page).to have_content('Modalidades de Transporte disponíveis:')
        expect(page).to have_content('Modal Rodoviário')
        expect(page).to have_link('mais informações')

    end
    it 'e vê mensagem quando não há modo de transporte cadastrado' do
      # Arrange
      user = FactoryBot.create(:user)

      # Act
      login_as(user)
      visit root_path
      click_on('Modos de Transporte')

      # Assert
      expect(page).to have_content('Modalidades de Transporte disponíveis:')
      expect(page).to have_content('Nenhuma Modalidade de Transporte Cadastrada')


    end
    it 'e vê mais detalhes de um modo de transporte' do
        # Arrange
        user = FactoryBot.create(:user)
        TransportMode.create(name: 'Modal Rodoviário', min_distance: 10, max_distance: 100, min_weight: 10,
          max_weight: 100, fixed_rate: 10.00)

        # Act
        login_as(user)
        visit transport_modes_path
        click_on('mais informações')

        # Assert
        expect(page).to have_content 'Modal Rodoviário (Inativo)'
        expect(page).to have_content 'Tabela de informações de uso'
        expect(page).to have_content '10km'
        expect(page).to have_content '100km'
        expect(page).to have_content '10kg'
        expect(page).to have_content '100kg'
        expect(page).to have_content 'R$ 10,00'

    end
    it 'e volta para a lista de modos de transporte' do
      # Arrange
      user = FactoryBot.create(:user)
      TransportMode.create(name: 'Modal Rodoviário', min_distance: 10, max_distance: 100, min_weight: 10,
        max_weight: 100, fixed_rate: 10.00)

      # Act
      login_as(user)
      visit transport_modes_path
      click_on('mais informações')
      click_on('Voltar')
      # Assert
      expect(current_path).to eq transport_modes_path
    end
end
