require 'rails_helper'

describe 'Usuário busca por uma Ordem de Serviço' do
  it 'a partir da lista da pagina inicial' do
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(page).to have_content('Consultar Ordem de Serviço')
    expect(page).to have_button('Buscar')

  end
  it 'e encontra uma Ordem de Serviço' do
    # Arrange
    order = FactoryBot.create(:order, status: :pending)

    # Act
    visit root_path
    fill_in 'Consultar Ordem de Serviço', with: order.code
    within('nav') do
      click_on 'Buscar'
    end

    # Assert
    expect(page).to have_content "Resultados da Busca por: #{order.code}"
    expect(page).to have_content 'Ordem de Serviço encontrada!'
    expect(page).to have_link order.code
    expect(page).to have_content "Status: Pendente"

   end
   it 'e entra na pagina da Ordem de Serviço' do
    # Arrange
    delivery = FactoryBot.create(:transport_mode, status: :active)
    vehicle = FactoryBot.create(:vehicle, maximum_load: 80, transport_mode: delivery, status: :out_for_delivery)
    order = FactoryBot.create(:order, status: :on_route)
    started_order = FactoryBot.create(:order_start, order: order, transport_mode: delivery, vehicle: vehicle)


    # Act
    visit root_path
    fill_in 'Consultar Ordem de Serviço', with: order.code
    within('nav') do
      click_on 'Buscar'
    end
    click_on order.code

    # Assert
    expect(current_path).to eq order_path(order)
   end
end
