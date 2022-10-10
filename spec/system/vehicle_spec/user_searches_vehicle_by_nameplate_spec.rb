require 'rails_helper'

describe 'Usuário busca por um Veículo' do
  it 'e deve estar autenticado' do
    # Arrange

    # Act
    visit vehicles_path

    # Assert
    expect(current_path).to eq new_user_session_path
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
    FactoryBot.create(:vehicle, nameplate: 'ABC1234', vehicle_brand: 'Nissan', vehicle_model: 'A140i')

    # Act
    login_as(user)
    visit vehicles_path
    fill_in 'Buscar Veículo', with: 'ABC1234'
    within('div#vehicle-search') do
      click_on 'Buscar'
    end

    # Assert
    expect(page).to have_content "Resultados da Busca por: ABC1234"
    expect(page).to have_content '1 Veículo encontrado'
    expect(page).to have_content "Nissan A140i - ABC1234"

   end
   it 'e entra na pagina do Veículo' do
    # Arrange
    user = FactoryBot.create(:user)
    vehicle = FactoryBot.create(:vehicle, nameplate: 'ABC1234', vehicle_brand: 'Nissan', vehicle_model: 'A140i')

    # Act
    login_as(user)
    visit vehicles_path
    fill_in 'Buscar Veículo', with: 'ABC1234'
    within('div#vehicle-search') do
      click_on 'Buscar'
    end
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
    within('div#vehicle-search') do
      click_on 'Buscar'
    end


    # Assert
    expect(page).to have_content "Nenhum resultado encontrado para a busca por: a"
   end
   it 'e encontra mais do que um Veículo' do
    # Arrange
    user = FactoryBot.create(:user)
    FactoryBot.create(:vehicle, nameplate: 'ABC1234', vehicle_brand: 'Nissan', vehicle_model: 'A140i')
    FactoryBot.create(:vehicle, nameplate: 'ABC3940', vehicle_brand: 'Nissan', vehicle_model: 'C13')
    FactoryBot.create(:vehicle, nameplate: 'CBD1930', vehicle_brand: 'Nissan', vehicle_model: 'B40')
    # Act
    login_as(user)
    visit vehicles_path
    fill_in 'Buscar Veículo', with: 'ABC'
    within('div#vehicle-search') do
      click_on 'Buscar'
    end

    # Assert
    expect(page).to have_content "Resultados da Busca por: ABC"
    expect(page).to have_content '2 Veículos encontrados'
    expect(page).to have_link "Nissan A140i - ABC1234"
    expect(page).to have_link "Nissan C13 - ABC3940"
   end
end
