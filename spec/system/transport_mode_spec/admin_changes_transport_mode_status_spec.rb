require 'rails_helper'

describe 'Admin tenta mudar o status de ativação de um modo de transporte' do
  it 'e não encontra botão se entra como usuário comum' do
    # Arrange
    user = FactoryBot.create(:user, admin: false)
    FactoryBot.create(:transport_mode, status: 0)

    # Act
    login_as(user)
    visit transport_modes_path
    click_on('mais informações')


    # Assert
    expect(page).not_to have_button 'Desativar'
    expect(page).not_to have_button 'Ativar'

  end
  it 'do padrão (inativo), para ativo (com sucesso)' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)
    tm = FactoryBot.create(:transport_mode, status: 0, min_weight: 5, min_distance: 5, max_weight: 500, max_distance: 500)
    FactoryBot.create(:weight_table, min: 10, max:50, value: 1, transport_mode: tm)
    FactoryBot.create(:distance_table, min: 10, max:50, value: 10, transport_mode: tm)
    FactoryBot.create(:deadline, min: 10, max:50, time: 48, transport_mode: tm)

    # Act
    login_as(admin)
    visit transport_modes_path
    click_on('mais informações')
    click_on('Ativar')

    # Assert
    expect(page).to have_button 'Desativar'
    expect(page).to have_content 'Ativo'
    expect(page).to have_content 'Modo de Transporte ativado.'
  end
  it 'de ativo, para inativo (com sucesso)' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)
    tm = FactoryBot.create(:transport_mode, status: 0, min_weight: 5, min_distance: 5, max_weight: 500, max_distance: 500)
    FactoryBot.create(:weight_table, min: 10, max:50, value: 1, transport_mode: tm)
    FactoryBot.create(:distance_table, min: 10, max:50, value: 10, transport_mode: tm)
    FactoryBot.create(:deadline, min: 10, max:50, time: 48, transport_mode: tm)
    tm.active!

    # Act
    login_as(admin)
    visit transport_modes_path
    click_on('mais informações')
    click_on('Desativar')

    # Assert
    expect(page).to have_button 'Ativar'
    expect(page).to have_content 'Inativo'
    expect(page).to have_content 'Modo de Transporte desativado.'
  end
  it 'e encontra erro ao tentar ativar um modo de transporte sem tabela de peso cadastrada' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)
    FactoryBot.create(:transport_mode, status: 0, min_weight: 5, min_distance: 5, max_weight: 500, max_distance: 500)


    # Act
    login_as(admin)
    visit transport_modes_path
    click_on('mais informações')
    click_on('Ativar')

    # Assert
    expect(page).to have_button 'Ativar'
    expect(page).to have_content 'Inativo'
    expect(page).to have_content 'Modo de Transporte não pode ser ativado com tabela de peso em branco'
  end
  it 'e encontra erro ao tentar ativar um modo de transporte sem tabela de distância cadastrada' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)
    tm = FactoryBot.create(:transport_mode, status: 0, min_weight: 5, min_distance: 5, max_weight: 500, max_distance: 500)
    FactoryBot.create(:weight_table, min: 10, max:50, value: 1, transport_mode: tm)

    # Act
    login_as(admin)
    visit transport_modes_path
    click_on('mais informações')
    click_on('Ativar')

    # Assert
    expect(page).to have_button 'Ativar'
    expect(page).to have_content 'Inativo'
    expect(page).to have_content 'Modo de Transporte não pode ser ativado com tabela de distância em branco'
  end
  it 'e encontra erro ao tentar ativar um modo de transporte sem tabela de prazos cadastrada' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)
    tm = FactoryBot.create(:transport_mode, status: 0, min_weight: 5, min_distance: 5, max_weight: 500, max_distance: 500)
    FactoryBot.create(:weight_table, min: 10, max:50, value: 1, transport_mode: tm)
    FactoryBot.create(:distance_table, min: 10, max:50, value: 10, transport_mode: tm)

    # Act
    login_as(admin)
    visit transport_modes_path
    click_on('mais informações')
    click_on('Ativar')

    # Assert
    expect(page).to have_button 'Ativar'
    expect(page).to have_content 'Inativo'
    expect(page).to have_content 'Modo de Transporte não pode ser ativado com tabela de prazos em branco'
  end
end
