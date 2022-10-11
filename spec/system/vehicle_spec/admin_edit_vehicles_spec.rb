require 'rails_helper'

describe 'Administrador entra na pagina de editar Veículos' do
  it 'a partir da tela de veículos' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)
    FactoryBot.create(:vehicle, nameplate: 'ABC1234', vehicle_brand: 'Nissan', vehicle_model: 'A140i')

    # Act
    login_as(admin)
    visit vehicles_path
    click_on 'Nissan A140i - ABC1234'
    click_on 'Editar dados do Veículo'

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
    FactoryBot.create(:transport_mode, name: 'Modal marítimo')
    FactoryBot.create(:vehicle, nameplate: 'ABC1234', vehicle_brand: 'Nissan', vehicle_model: 'A140i')

    # Act
    login_as(admin)
    visit vehicles_path
    click_on 'Nissan A140i - ABC1234'
    click_on 'Editar dados do Veículo'
    fill_in 'Marca do Veículo', with: 'Mistubishi'
    fill_in 'Modelo do Veículo', with: 'TI120m'
    fill_in 'Placa de Identificação', with: 'CDA3940'
    fill_in 'Carga máxima', with: 60
    fill_in 'Ano de Fabricação', with: 1992
    select 'Modal marítimo', :from => 'Modalidade de Transporte'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Veículo Atualizado com sucesso.'
    expect(page).to have_content 'Mistubishi TI120m - CDA3940'
    expect(page).to have_content 'Ano de Fabricação: 1992'
    expect(page).to have_content 'Carga máxima: 60kg'
    expect(page).to have_link 'Modal marítimo'
    expect(page).to have_content 'Disponível'

  end
end
