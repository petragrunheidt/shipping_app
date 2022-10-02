require 'rails_helper'

describe 'Administrador entra na pagina de cadastrar novo modo de transporte' do
  it 'a partir da tela de administradores' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)
    FactoryBot.create(:transport_mode)

    # Act
    login_as(admin)
    visit admin_dashboard_index_path
    click_on 'Cadastrar novo Modo de Transporte'

    # Assert
    expect(page).to have_field TransportMode.human_attribute_name('name')
    expect(page).to have_field TransportMode.human_attribute_name('min_weight')
    expect(page).to have_field TransportMode.human_attribute_name('max_weight')
    expect(page).to have_field TransportMode.human_attribute_name('min_distance')
    expect(page).to have_field TransportMode.human_attribute_name('max_distance')
    expect(page).to have_field TransportMode.human_attribute_name('shipping_value')
  end
  it 'com sucesso' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)

    # Act
    login_as(admin)
    visit admin_dashboard_index_path
    click_on 'Cadastrar novo Modo de Transporte'
    fill_in 'Nome', with: 'Modal Rodoviário'
    fill_in 'Carga mínima', with: 10
    fill_in 'Carga máxima', with: 100
    fill_in 'Distância mínima', with: 10
    fill_in 'Distância máxima', with: 100
    fill_in 'Valor do frete', with: 10.00
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Modo de Transporte Cadastrado com sucesso.'
    expect(page).to have_content 'Modal Rodoviário'
    expect(page).to have_content 'Tabela de informações de uso'
    expect(page).to have_content '10km'
    expect(page).to have_content '100km'
    expect(page).to have_content '10kg'
    expect(page).to have_content '100kg'
    expect(page).to have_content 'R$ 10,00'

  end
  it 'e encontra mensagens de erro ao deixar campos em branco' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)

    # Act
    login_as(admin)
    visit admin_dashboard_index_path
    click_on 'Cadastrar novo Modo de Transporte'
    fill_in 'Nome', with: 'Modal Rodoviário'
    fill_in 'Carga mínima', with: ''
    fill_in 'Carga máxima', with: ''
    fill_in 'Distância mínima', with: 10
    fill_in 'Distância máxima', with: 100
    fill_in 'Valor do frete', with: 10.00
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Carga mínima não pode ficar em branco'
    expect(page).to have_content 'Carga máxima não pode ficar em branco'

  end
end
