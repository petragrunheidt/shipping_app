require 'rails_helper'

describe 'Usuário vê Ordens de Serviço cadastrados' do
    it 'na pagina de Ordens de Serviço (em forma de lista)' do
        # Arrange
        user = FactoryBot.create(:user)
        order = FactoryBot.create(:order, status: 0)

        # Act
        login_as(user)
        visit root_path
        click_on('Ordens de Serviço')

        # Assert
        expect(page).to have_content("Ordem de Serviço: #{order.code}")
        expect(page).to have_link("#{order.code}")
        expect(page).to have_content("Status: Pendente")


    end
    it 'e vê mensagem quando não há Ordens de serviço cadastrados' do
      # Arrange
      user = FactoryBot.create(:user)

      # Act
      login_as(user)
      visit root_path
      click_on('Ordens de Serviço')

      # Assert
      expect(page).to have_content('Ordens de Serviço')
      expect(page).to have_content('Nenhuma Ordem de serviço Cadastrada')


    end
    it 'e vê mais detalhes de uma ordem de serviço' do
        # Arrange
        user = FactoryBot.create(:user)
        order = Order.create(takeout_address:  "Rua da Transportadora 101",
                      weight:  10,
                      heigth:  10,
                      width:  10,
                      depth:  10,
                      delivery_address:  "Rua da Petra 60",
                      name:  "Petra",
                      email:  "petra@mail.com",
                      customer_id:  "193029304",
                      total_distance: 100,
                      status: 0)

        # Act
        login_as(user)
        visit root_path
        click_on('Ordens de Serviço')
        click_on order.code

        # Assert
        expect(page).to have_link("ABCDEFGHIJ12345")
        expect(page).to have_content("Status: Pendente")

    end
    it 'acessa uma ordem especifica e volta para a lista de Ordens de Serviço' do
      # Arrange
      user = FactoryBot.create(:user)
      order = FactoryBot.create(:order)

      # Act
      login_as(user)
      visit root_path
      click_on('Ordens de Serviço')
      click_on order.code
      click_on('Voltar')
      # Assert
      expect(current_path).to eq orders_path
    end
end
