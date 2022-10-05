require 'rails_helper'

describe 'Usuário busca por um Veículo' do
  it 'e deve estar autenticado' do
    # Arrange

    # Act
    visit vehicles_path

    # Assert
    expect(page).not_to have_field('Buscar Veículo por placa')
    expect(page).not_to have_button('Buscar')
  end
  it 'a partir da lista de Veículos' do
    # Arrange
    user = FactoryBot.build(:user)


    # Act
    login_as(user)
    visit vehicles_path

    # Assert
    expect(page).to have_button('Buscar')

  end
  it 'e encontra um Veículo' do
    # Arrange
    user = FactoryBot.create(:user)
    vehicle = FactoryBot.build(:vehicle, nameplate: 'ABC1234')

    # Act
    login_as(user)
    visit vehicles_path
    fill_in 'Buscar Veículo', with: "ABC1234"
    click_on 'Buscar'

    # Assert
    expect(page).to have_content "Resultados da Busca por: ABC1234"
    expect(page).to have_content '1 Veículo encontrado'
    expect(page).to have_content "Código: 'ABC1234'"

   end
   it 'e entra na pagina do Veículo' do
    # Arrange
    user = FactoryBot.create(:user)
    vehicle = FactoryBot.create(:vehicle, nameplate: 'ABC1234', vehicle_brand: 'Nissan', vehicle_model: 'A140i')

    # Act
    login_as(user)
    visit vehicles_path
    fill_in 'Buscar Veículo', with: vehicle.nameplate
    click_on 'Buscar'
    click_on('Nissan A140i - ABC1234')

    # Assert
    expect(current_path).to eq vehicle_path(vehicle)
   end
   it 'e não encontra um Veículo' do
    # Arrange
    user = FactoryBot.create(:user)

    # Act
    login_as(user)
    visit vehicles_path
    fill_in 'Buscar Veículo', with: 'a'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content "Nenhum resultado encontrado para a busca por: a"
   end
   it 'e encontra mais do que um Veículo' do
    # Arrange
    user = FactoryBot.create(:user)
    vehicle1 = FactoryBot.create(:vehicle, nameplate: 'ABC1234', vehicle_brand: 'Nissan', vehicle_model: 'A140i')
    vehicle2 = FactoryBot.create(:vehicle, nameplate: 'ABC3940', vehicle_brand: 'Nissan', vehicle_model: 'C13')
    FactoryBot.create(:vehicle, nameplate: 'CBD1930', vehicle_brand: 'Nissan', vehicle_model: 'B40')
    # Act
    login_as(user)
    visit vehicles_path
    fill_in 'Buscar Veículo', with: 'ABC'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content "Resultados da Busca por: ABC"
    expect(page).to have_content '2 Veículos encontrados'
    expect(page).to have_link "Galpão Destino: Nissan A140i - ABC1234"
    expect(page).to have_link "Galpão Destino: Nissan C13 - ABC3940"
   end
end
