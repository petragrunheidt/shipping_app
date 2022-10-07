require 'rails_helper'

describe 'Usuário tenta editar linha em tabela de preços' do
    it 'e não encontra o link de edição quando não é admin' do
        # Arrange
        user = FactoryBot.create(:user)
        tm = FactoryBot.create(:transport_mode, name: 'Frota de Caminhões')
        FactoryBot.create(:weight_table, transport_mode: tm)
        FactoryBot.create(:distance_table, transport_mode: tm)


        # Act
        login_as(user)
        visit transport_modes_path
        click_on('mais informações')

        # Assert
        expect(page).not_to have_link 'Editar linha 1'

    end

    it 'e edita uma linha da tabela de peso com sucesso' do
        # Arrange
        user = FactoryBot.create(:user, admin: true)
        tm = FactoryBot.create(:transport_mode, name: 'Frota de Caminhões', min_weight: 10, max_weight: 100)
        FactoryBot.create(:weight_table, min: 10, max:20, value: 0.8, transport_mode: tm)

        # Act
        login_as(user)
        visit transport_modes_path
        click_on('mais informações')
        within('div#weight-table') do
          click_on 'Editar linha 1'
        end
        fill_in 'Peso Mínimo', with: 20
        fill_in 'Peso Máximo', with: 30
        fill_in 'Valor por Peso', with: 0.75
        click_on 'Enviar'

        # Assert

        expect(page).to have_content('Linha 1 editada com sucesso.')
        expect(page).to have_content 'Intervalo de pesos'
        expect(page).to have_content 'Preço por kg'
        expect(page).to have_content '20kg'
        expect(page).to have_content '30kg'
        expect(page).to have_content 'R$ 0,75'
    end

  it 'e edita uma linha da tabela de distância com sucesso' do
      # Arrange
      user = FactoryBot.create(:user, admin: true)
      tm = FactoryBot.create(:transport_mode, name: 'Frota de Caminhões', min_distance: 10, max_distance: 100)
      FactoryBot.create(:distance_table, min: 10, max:20, value: 0.8, transport_mode: tm)



        # Act
        login_as(user)
        visit transport_modes_path
        click_on('mais informações')
      within('div#distance-table') do
        click_on 'Editar linha 1'
      end
      fill_in 'Distância Mínima', with: 20
      fill_in 'Distância Máxima', with: 30
      fill_in 'Valor por faixa de Distância', with: 0.75
      click_on 'Enviar'

      # Assert

      expect(page).to have_content('Linha 1 editada com sucesso.')
      expect(page).to have_content 'Intervalo de Distâncias'
      expect(page).to have_content 'Preço por faixa de km'
      expect(page).to have_content '20km'
      expect(page).to have_content '30km'
      expect(page).to have_content 'R$ 0,75'
  end
end
