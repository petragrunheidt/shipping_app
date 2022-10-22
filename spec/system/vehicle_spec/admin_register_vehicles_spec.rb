require 'rails_helper'

describe 'Administrador entra na pagina de cadastrar novo Veículo' do
  it 'a partir da tela inicial' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)
    FactoryBot.create(:vehicle)

    # Act
    login_as(admin)
    visit vehicles_path
    click_on 'Cadastrar novo Veículo'

    # Assert
    expect(page).to have_field 'Marca do Veículo'
    expect(page).to have_field 'Modelo do Veículo'
    expect(page).to have_field 'Placa de Identificação'
    expect(page).to have_field 'Carga máxima'
    expect(page).to have_field 'Ano de Fabricação'
    expect(page).to have_field 'Modalidade de Transporte'
  end
  it 'com sucesso' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)
    FactoryBot.create(:transport_mode, name: 'Frota de Carros')

    # Act
    login_as(admin)
    visit vehicles_path
    click_on 'Cadastrar novo Veículo'
    fill_in 'Marca do Veículo', with: 'Nissan'
    fill_in 'Modelo do Veículo', with: 'TI120m'
    fill_in 'Placa de Identificação', with: 'ABC1234'
    fill_in 'Carga máxima', with: 80
    fill_in 'Ano de Fabricação', with: 1995
    select 'Frota de Carros', :from => 'Modalidade de Transporte'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Veículo Cadastrado com sucesso.'
    expect(page).to have_content 'Nissan TI120m - ABC1234'
    expect(page).to have_content 'Ano de Fabricação: 1995'
    expect(page).to have_content 'Carga máxima: 80kg'
    expect(page).to have_link 'Frota de Carros'
    expect(page).to have_content 'Manutenção'

  end
  it 'e encontra mensagens de erro ao deixar campos em branco' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)

    # Act
    login_as(admin)
    visit vehicles_path
    click_on 'Cadastrar novo Veículo'
    fill_in 'Marca do Veículo', with: 'Nissan'
    fill_in 'Modelo do Veículo', with: 'TI120m'
    fill_in 'Carga máxima', with: 80
    fill_in 'Ano de Fabricação', with: 1995
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Modalidade de Transporte é obrigatório(a)'
    expect(page).to have_content 'Placa de Identificação não pode ficar em branco'

  end
end
