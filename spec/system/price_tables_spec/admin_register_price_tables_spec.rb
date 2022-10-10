require 'rails_helper'

describe 'Usuário tenta cadastrar linha em tabela de preços' do
    it 'e não encontra os campos quando não é admin' do
        # Arrange
        user = FactoryBot.create(:user)
        FactoryBot.create(:transport_mode)

        # Act
        login_as(user)
        visit transport_modes_path
        click_on('mais informações')

        # Assert
        expect(page).not_to have_field 'Peso Mínimo'
        expect(page).not_to have_field 'Peso Máximo'
        expect(page).not_to have_field 'Valor por Peso'
        expect(page).not_to have_field 'Distância Mínima'
        expect(page).not_to have_field 'Distância Máxima'
        expect(page).not_to have_field 'Valor por faixa de Distância'

    end
    it 'e encotnra os campos para adicionar linha a uma tabela de peso vazia' do
        # Arrange
        user = FactoryBot.create(:user, admin: true)
        FactoryBot.create(:transport_mode)

        # Act
        login_as(user)
        visit transport_modes_path
        click_on('mais informações')

        # Assert
        expect(page).to have_field 'Peso Mínimo'
        expect(page).to have_field 'Peso Máximo'
        expect(page).to have_field 'Valor por Peso'

    end

    it 'e adiciona a linha a uma tabela de peso com sucesso' do
        # Arrange
        user = FactoryBot.create(:user, admin: true)
        tm = FactoryBot.create(:transport_mode, name: 'Frota de Caminhões', min_weight: 10, max_weight: 100)

        # Act
        login_as(user)
        visit transport_modes_path
        click_on('mais informações')
        within('div#weight-table') do
            fill_in 'Peso Mínimo', with: 10
            fill_in 'Peso Máximo', with: 20
            fill_in 'Valor por Peso', with: 0.80
            click_on 'Enviar'
        end


        # Assert

        expect(page).to have_content('Linha 1 adicionada com sucesso.')
        expect(page).to have_content 'Intervalo de pesos'
        expect(page).to have_content 'Preço por kg'
        expect(page).to have_content '10kg'
        expect(page).to have_content '20kg'
        expect(page).to have_content 'R$ 0,80'
    end
    it 'e acessa a pagina de adicionar linha a uma tabela de distância' do
        # Arrange
        user = FactoryBot.create(:user, admin: true)
        tm = FactoryBot.create(:transport_mode, name: 'Frota de Caminhões')


        # Act
        login_as(user)
        visit transport_modes_path
        click_on('mais informações')

        # Assert
        expect(page).to have_field 'Distância Mínima'
        expect(page).to have_field 'Distância Máxima'
        expect(page).to have_field 'Valor por faixa de Distância'

    end
    it 'e adiciona a linha a uma tabela de distância com sucesso' do
        # Arrange
        user = FactoryBot.create(:user, admin: true)
        tm = FactoryBot.create(:transport_mode, name: 'Frota de Caminhões', min_weight: 10, max_weight: 100)

        # Act
        login_as(user)
        visit transport_modes_path
        click_on('mais informações')
        within('div#distance-table') do
            fill_in 'Distância Mínima', with: 10
            fill_in 'Distância Máxima', with: 30
            fill_in 'Valor por faixa de Distância', with: 0.65
            select 'Frota de Caminhões', :from => 'Modalidade de Transporte'
            click_on 'Enviar'
        end

        # Assert

        expect(page).to have_content('Linha 1 adicionada com sucesso.')
        expect(page).to have_content 'Intervalo de Distâncias'
        expect(page).to have_content 'Preço por faixa de km'
        expect(page).to have_content '10km'
        expect(page).to have_content '30km'
        expect(page).to have_content 'R$ 0,65'
    end
end
