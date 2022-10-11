require 'rails_helper'

describe 'Administrador entra na pagina de editar modo de transporte' do
  it 'a partir da tela inicial' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)
    FactoryBot.create(:transport_mode)
    # Act
    login_as(admin)
    visit root_path
    click_on 'Modos de Transporte'
    click_on 'mais informações'
    click_on 'Editar Modo de Transporte'

    # Assert
    expect(page).to have_field TransportMode.human_attribute_name('name')
    expect(page).to have_field TransportMode.human_attribute_name('min_weight')
    expect(page).to have_field TransportMode.human_attribute_name('max_weight')
    expect(page).to have_field TransportMode.human_attribute_name('min_distance')
    expect(page).to have_field TransportMode.human_attribute_name('max_distance')
    expect(page).to have_field TransportMode.human_attribute_name('fixed_rate')
  end
  it 'com sucesso' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)
    FactoryBot.create(:transport_mode)
    # Act
    login_as(admin)
    visit root_path
    click_on 'Modos de Transporte'
    click_on 'mais informações'
    click_on 'Editar Modo de Transporte'
    fill_in 'Nome', with: 'Modal Rodoviário'
    fill_in 'Carga mínima', with: 100
    fill_in 'Carga máxima', with: 1000
    fill_in 'Distância mínima', with: 10
    fill_in 'Distância máxima', with: 999
    fill_in 'Taxa Fixa', with: 12.50
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Modo de Transporte Atualizado com sucesso.'
    expect(page).to have_content 'Modal Rodoviário'
    expect(page).to have_content 'Tabela de informações de uso'
    expect(page).to have_content '100kg'
    expect(page).to have_content '1000kg'
    expect(page).to have_content '10km'
    expect(page).to have_content '999km'
    expect(page).to have_content 'R$ 12,50'

  end
end
