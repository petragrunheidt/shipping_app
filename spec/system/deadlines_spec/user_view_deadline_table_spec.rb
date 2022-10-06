require 'rails_helper'

describe 'Usuário acessa tabelas de prazos em modos de transporte' do
    it 'e vê tabela de prazos' do
        # Arrange
        user = FactoryBot.create(:user)
        tm = FactoryBot.create(:transport_mode, name: 'Frota de Caminhões', min_weight: 10, max_weight: 100)
        Deadline.create(min: 10, max: 30, time: 24, transport_mode: tm)

        # Act
        login_as(user)
        visit transport_modes_path
        click_on('mais informações')

        # Assert
        expect(page).to have_content('Tabela de Prazos')
        expect(page).to have_content 'Faixa de Distâncias'
        expect(page).to have_content 'Prazo'
        expect(page).to have_content '10km'
        expect(page).to have_content '30km'
        expect(page).to have_content '24h'

    end
  end
