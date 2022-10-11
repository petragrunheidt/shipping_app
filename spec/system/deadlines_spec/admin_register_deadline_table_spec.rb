require 'rails_helper'

describe 'Usuário tenta cadastrar linha em tabela de prazos' do
    it 'e não encontra o botão quando não é admin' do
        # Arrange
        user = FactoryBot.create(:user)
        FactoryBot.create(:transport_mode)

        # Act
        login_as(user)
        visit transport_modes_path
        click_on('mais informações')

        # Assert
        expect(page).not_to have_field 'Distância Mínima'
        expect(page).not_to have_field 'Distância Máxima'
        expect(page).not_to have_field 'Tempo de Entrega'

    end
    it 'e acessa a pagina de adicionar linha a uma tabela de Prazo vazia' do
        # Arrange
        user = FactoryBot.create(:user, admin: true)
        FactoryBot.create(:transport_mode)

        # Act
        login_as(user)
        visit transport_modes_path
        click_on('mais informações')


        # Assert
        expect(page).to have_field 'Distância Mínima'
        expect(page).to have_field 'Distância Máxima'
        expect(page).to have_field 'Tempo de Entrega'

    end

    it 'e adiciona a linha a uma tabela de Prazo vazia com sucesso' do
        # Arrange
        user = FactoryBot.create(:user, admin: true)
        tm = FactoryBot.create(:transport_mode, name: 'Frota de Caminhões', min_weight: 10, max_weight: 100)

        # Act
        login_as(user)
        visit transport_modes_path
        click_on('mais informações')
        within('div#deadline-table') do
          fill_in 'Distância Mínima', with: 10
          fill_in 'Distância Máxima', with: 20
          fill_in 'Tempo de Entrega', with: 24
          click_on 'Enviar'
        end

        # Assert

        expect(page).to have_content('Linha 1 da tabela de prazos adicionada com sucesso.')
        expect(page).to have_content 'Intervalo de Distâncias'
        expect(page).to have_content 'Tempo de Entrega'
        expect(page).to have_content '10km'
        expect(page).to have_content '20km'
        expect(page).to have_content '24h'
    end
end
