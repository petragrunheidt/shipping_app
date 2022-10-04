require 'rails_helper'

describe 'Usuário vê pagina de tabela de preços' do
    it 'e vê tabela de preço por peso' do
        # Arrange
        user = FactoryBot.create(:user)
        tm = FactoryBot.create(:transport_mode)
        WeightTable.create(min: 0, max: 30, value: 0.50, transport_mode: tm)

        # Act
        login_as(user)
        visit transport_modes_path
        click_on('mais informações')

        # Assert
        expect(page).to have_content('Tabela de preços por faixa de Peso')
        expect(page).to have_content 'Intervalo de pesos'
        expect(page).to have_content 'Preço por kg'
        expect(page).to have_content '0kg'
        expect(page).to have_content '30kg'
        expect(page).to have_content 'R$ 0,50'

    end
    it 'e vê tabela de preço por distancia' do
      # Arrange
      user = FactoryBot.create(:user)
      tm = FactoryBot.create(:transport_mode)
      DistanceTable.create(min: 0, max: 20, value: 100.75, transport_mode: tm)

      # Act
      login_as(user)
      visit transport_modes_path
      click_on('mais informações')

      # Assert
      expect(page).to have_content('Tabela de preços por faixa de Distância')
      expect(page).to have_content 'Intervalo de distâncias'
      expect(page).to have_content 'Preço por km'
      expect(page).to have_content '0km'
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
