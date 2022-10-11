require 'rails_helper'

describe 'Usuário tenta editar linha em tabela de prazos' do
    it 'e não encontra o link de edição quando não é admin' do
        # Arrange
        user = FactoryBot.create(:user)
        tm = FactoryBot.create(:transport_mode, name: 'Frota de Caminhões', min_distance: 10, max_distance: 100)
        FactoryBot.create(:deadline, transport_mode: tm)

        # Act
        login_as(user)
        visit transport_modes_path
        click_on('mais informações')

        # Assert
        expect(page).not_to have_link 'Editar linha 1'

    end
    it 'e edita uma linha da tabela de prazos com sucesso' do
        # Arrange
        user = FactoryBot.create(:user, admin: true)
        tm = FactoryBot.create(:transport_mode, name: 'Frota de Caminhões', min_distance: 10, max_distance: 100)
        FactoryBot.create(:deadline, min: 10, max:20, time: 24, transport_mode: tm)

        # Act
        login_as(user)
        visit transport_modes_path
        click_on('mais informações')
        within('div#deadline-table') do
          click_on 'Editar linha 1'
        end
        fill_in 'Distância Mínima', with: 20
        fill_in 'Distância Máxima', with: 60
        fill_in 'Tempo de Entrega', with: 48
        click_on 'Enviar'

        # Assert

        expect(page).to have_content('Linha 1 da tabela de prazos editada com sucesso.')
        expect(page).to have_content 'Intervalo de Distâncias'
        expect(page).to have_content 'Prazo'
        expect(page).to have_content '20km'
        expect(page).to have_content '60km'
        expect(page).to have_content '48h'
    end
  end
