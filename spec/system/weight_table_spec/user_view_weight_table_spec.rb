require 'rails_helper'

describe 'Usuário vê tabela de preços por peso' do
    it 'na pagina de tabelas de preço' do
        # Arrange
        user = FactoryBot.create(:user)
        WeightTable.create(min: 0, max: 30, value: 0.50)

        # Act
        login_as(user)
        visit root_path
        click_on('Tabelas de Preço')

        # Assert
        expect(page).to have_content('Tabela de preços por peso')
        expect(page).to have_content 'Intervalo de pesos'
        expect(page).to have_content 'Preço por kg'
        expect(page).to have_content '0kg'
        expect(page).to have_content '30kg'
        expect(page).to have_content 'R$ 0,50'

    end
    it 'e vê mensagem quando não há tabela cadastrada' do
      # Arrange
      user = FactoryBot.create(:user)

      # Act
      login_as(user)
      visit root_path
      click_on('Tabelas de Preço')

      # Assert
      expect(page).to have_content('Tabela de preços por peso')
      expect(page).to have_content('Nenhum dado cadastrado.')


    end
    it 'e volta para a página ínicial' do
      # Arrange
      user = FactoryBot.create(:user)

      # Act
      login_as(user)
      visit root_path
      click_on('Tabelas de Preço')
      click_on('Voltar')
      # Assert
      expect(current_path).to eq root_path
    end
end
