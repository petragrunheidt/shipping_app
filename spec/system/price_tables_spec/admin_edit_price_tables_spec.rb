require 'rails_helper'

describe 'Usuário tenta editar linha em tabela de preços' do
    it 'e não encontra o link de edição quando não é admin' do
        # Arrange
        user = FactoryBot.create(:user)
        FactoryBot.create(:weight_table)
        FactoryBot.create(:distance_table)

        # Act
        login_as(user)
        visit price_tables_path

        # Assert
        expect(page).not_to have_link 'Editar linha 1'

    end
    it 'e acessa a pagina de editar a linha do meio de uma tabela de peso' do
        # Arrange
        user = FactoryBot.create(:user, admin: true)
        FactoryBot.create(:weight_table, min: 0, max: 20, value: 0.5)
        FactoryBot.create(:weight_table, min: 21, max: 60, value: 0.9)
        FactoryBot.create(:weight_table, min: 61, max: 120, value: 1.25)

        # Act
        login_as(user)
        visit price_tables_path
        within('div#weight-table') do
          click_on 'Editar linha 2'
        end

        # Assert
        expect(page).to have_content 'Editar linha 2 da Tabela de Peso'
        expect(page).to have_content '0kg'
        expect(page).to have_content '20kg'
        expect(page).to have_content 'R$ 0,50'
        expect(page).to have_content '61kg'
        expect(page).to have_content '120kg'
        expect(page).to have_content 'R$ 1,25'

    end
    it 'e edita uma linha da tabela de peso com sucesso' do
        # Arrange
        user = FactoryBot.create(:user, admin: true)
        FactoryBot.create(:weight_table, min: 0, max: 20, value: 0.8)

        # Act
        login_as(user)
        visit price_tables_path
        within('div#weight-table') do
          click_on 'Editar linha 1'
        end
        fill_in 'Peso Mínimo', with: 10
        fill_in 'Peso Máximo', with: 30
        fill_in 'Valor por Peso', with: 0.75
        click_on 'Enviar'

        # Assert

        expect(page).to have_content('Linha 1 editada com sucesso.')
        expect(page).to have_content 'Intervalo de pesos'
        expect(page).to have_content 'Preço por kg'
        expect(page).to have_content '10kg'
        expect(page).to have_content '30kg'
        expect(page).to have_content 'R$ 0,75'
    end
    it 'e acessa a pagina de editar a linha do meio de uma tabela de distância' do
      # Arrange
      user = FactoryBot.create(:user, admin: true)
      FactoryBot.create(:distance_table, min: 0, max: 20, value: 0.5)
      FactoryBot.create(:distance_table, min: 21, max: 60, value: 0.9)
      FactoryBot.create(:distance_table, min: 61, max: 120, value: 1.25)

      # Act
      login_as(user)
      visit price_tables_path
      within('div#distance-table') do
        click_on 'Editar linha 2'
      end

      # Assert
      expect(page).to have_content 'Editar linha 2 da Tabela de Distância'
      expect(page).to have_content '0km'
      expect(page).to have_content '20km'
      expect(page).to have_content 'R$ 0,50'
      expect(page).to have_content '61km'
      expect(page).to have_content '120km'
      expect(page).to have_content 'R$ 1,25'

  end
  it 'e edita uma linha da tabela de distância com sucesso' do
      # Arrange
      user = FactoryBot.create(:user, admin: true)
      FactoryBot.create(:distance_table, min: 0, max: 20, value: 0.8)

      # Act
      login_as(user)
      visit price_tables_path
      within('div#distance-table') do
        click_on 'Editar linha 1'
      end
      fill_in 'Distância Mínima', with: 10
      fill_in 'Distância Máxima', with: 30
      fill_in 'Valor por Distância', with: 0.75
      click_on 'Enviar'

      # Assert

      expect(page).to have_content('Linha 1 editada com sucesso.')
      expect(page).to have_content 'Intervalo de distâncias'
      expect(page).to have_content 'Preço por km'
      expect(page).to have_content '10km'
      expect(page).to have_content '30km'
      expect(page).to have_content 'R$ 0,75'
  end
end
