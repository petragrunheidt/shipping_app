require 'rails_helper'

describe 'Administrador entra na pagina de cadastrar nova Ordem de Serviço' do
  it 'a partir da tela de ordens de serviço' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)

    # Act
    login_as(admin)
    visit orders_path
    click_on 'Cadastrar nova Ordem de Serviço'

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
    expect(page).to have_field 'CPF'
  end
  it 'e faz o cadastro com sucesso' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)

    # Act
    login_as(admin)
    visit orders_path
    click_on 'Cadastrar nova Ordem de Serviço'
    fill_in 'Endereço de Retirada', with: 'Rua da Loja'
    fill_in 'Peso', with: 50
    fill_in 'Altura', with: 30
    fill_in 'Largura', with: 30
    fill_in 'Profundidade', with: 50
    fill_in 'Endereço de Entrega', with: 'Rua da Petra'
    fill_in 'Nome', with: 'Petra'
    fill_in 'Email', with: admin.email
    fill_in 'CPF', with: '10293029304914'
    fill_in 'Distância Total', with: 80
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Ordem de Serviço cadastrada com sucesso.'
    expect(page).to have_content 'Rua da Loja'
    expect(page).to have_content '30x30x50cm'
    expect(page).to have_content '50kg'
    expect(page).to have_content 'Rua da Petra'
    expect(page).to have_content 'Petra'
    expect(page).to have_content admin.email
    expect(page).to have_content '10293029304914'
    expect(page).to have_content '80km'

  end
  it 'e encontra mensagens de erro ao deixar campos em branco' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)

    # Act
    login_as(admin)
    visit orders_path
    click_on 'Cadastrar nova Ordem de Serviço'
    fill_in 'Endereço de Retirada', with: ''
    fill_in 'Peso', with: 50
    fill_in 'Altura', with: 30
    fill_in 'Largura', with: 30
    fill_in 'Profundidade', with: 50
    fill_in 'Endereço de Entrega', with: 'Rua da Petra'
    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    fill_in 'CPF', with: '10293049102934'
    fill_in 'Distância Total', with: 80
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Endereço de Retirada não pode ficar em branco'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Email não pode ficar em branco'

  end
end
