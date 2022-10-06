require 'rails_helper'

describe 'Usuário acessa tabelas de preço em modos de transporte' do
    it 'e vê tabela de preço por peso' do
        # Arrange
        user = FactoryBot.create(:user)
        tm = FactoryBot.create(:transport_mode, name: 'Frota de Caminhões', min_weight: 10, max_weight: 100)
        WeightTable.create(min: 10, max: 30, value: 0.50, transport_mode: tm)

        # Act
        login_as(user)
        visit transport_modes_path
        click_on('mais informações')

        # Assert
        expect(page).to have_content('Tabela de preços por faixa de Peso')
        expect(page).to have_content 'Intervalo de pesos'
        expect(page).to have_content 'Preço por kg'
        expect(page).to have_content '10kg'
        expect(page).to have_content '30kg'
        expect(page).to have_content 'R$ 0,50'

    end
    it 'e vê tabela de preço por distancia' do
      # Arrange
      user = FactoryBot.create(:user)
      tm = FactoryBot.create(:transport_mode, name: 'Frota de Caminhões', min_distance: 10, max_distance: 100)
      DistanceTable.create(min: 10, max: 20, value: 100.75, transport_mode: tm)

      # Act
      login_as(user)
      visit transport_modes_path
      click_on('mais informações')

      # Assert
      expect(page).to have_content('Tabela de preços por faixa de Distância')
      expect(page).to have_content 'Intervalo de Distâncias'
      expect(page).to have_content 'Preço por faixa de km'
      expect(page).to have_content '10km'
      expect(page).to have_content '20km'
      expect(page).to have_content 'R$ 100,75'

  end
    it 'e vê mensagem quando não há tabela de peso cadastrada' do
      # Arrange
      user = FactoryBot.create(:user)
      FactoryBot.create(:transport_mode)

      # Act
      login_as(user)
      visit transport_modes_path
      click_on('mais informações')

      # Assert
      expect(page).to have_content('Tabela de preços por faixa de Distância')
      expect(page).to have_content('Tabela de preços por faixa de Peso')
      expect(page).to have_content('Nenhum dado cadastrado.')


    end
    it 'e volta para a página ínicial' do
      # Arrange
      user = FactoryBot.create(:user)
      FactoryBot.create(:transport_mode)

      # Act
      login_as(user)
      visit transport_modes_path
      click_on('mais informações')
      click_on('Voltar')
      # Assert
      expect(current_path).to eq transport_modes_path
    end
end
