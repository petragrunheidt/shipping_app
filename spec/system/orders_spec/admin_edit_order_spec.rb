require 'rails_helper'

describe 'Usuário tenta editar Ordem de Serviço' do
    it 'e não encontra o link de edição quando não é admin' do
        # Arrange
        user = FactoryBot.create(:user)
        order = FactoryBot.create(:order)

        # Act
        login_as(user)
        visit root_path
        click_on('Ordens de Serviço')
        click_on order.code

        # Assert
        expect(page).not_to have_link 'Editar Ordem de Serviço'
    end
    it 'e acessa o formulário de edição' do
        # Arrange
        admin = FactoryBot.create(:user, admin: true)
        order = FactoryBot.create(:order)

        # Act
        login_as(admin)
        visit root_path
        click_on('Ordens de Serviço')
        click_on order.code
        click_on 'Editar Ordem de Serviço'

        # Assert
        expect(page).to have_field 'Endereço de Retirada'
        expect(page).to have_field 'Peso'
        expect(page).to have_field 'Altura'
        expect(page).to have_field 'Largura'
        expect(page).to have_field 'Profundidade'
        expect(page).to have_field 'Endereço de Entrega'
        expect(page).to have_field 'Nome'
        expect(page).to have_field 'Email'
        expect(page).to have_field 'Distância Total'
        expect(page).to have_field 'CPF/CNPJ'
    end
    it 'e faz a edição com sucesso' do
      # Arrange
      admin = FactoryBot.create(:user, admin: true)
      order = FactoryBot.create(:order, email: admin.email)

      # Act
      login_as(admin)
      visit root_path
      click_on('Ordens de Serviço')
      click_on order.code
      click_on 'Editar Ordem de Serviço'
      fill_in 'Endereço de Retirada', with: 'Rua da Loja'
      fill_in 'Peso', with: 50
      fill_in 'Altura', with: 30
      fill_in 'Largura', with: 30
      fill_in 'Profundidade', with: 50
      fill_in 'Endereço de Entrega', with: 'Rua da Petra'
      fill_in 'Nome', with: 'Petra'
      fill_in 'Email', with: 'pez@mail.com'
      fill_in 'CPF/CNPJ', with: '49301920394'
      fill_in 'Distância Total', with: 80
      click_on 'Enviar'

      # Assert
      expect(page).to have_content 'Ordem de Serviço atualizada com sucesso.'
      expect(page).to have_content 'Rua da Loja'
      expect(page).to have_content '30x30x50cm'
      expect(page).to have_content '50kg'
      expect(page).to have_content 'Rua da Petra'
      expect(page).to have_content 'Petra'
      expect(page).to have_content 'pez@mail.com'
      expect(page).to have_content '49301920394'
      expect(page).to have_content '80km'
  end
end
