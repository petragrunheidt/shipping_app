require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Petra', email: 'eu@sistemadefrete.com.br', password: 'password')
    # Act
    visit root_path
    click_on 'Iniciar Sessão'
    fill_in 'E-mail', with: 'eu@sistemadefrete.com.br'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'

    # Assert
    within('nav') do
    expect(page).to have_button 'Encerrar Sessão'
    expect(page).not_to have_link 'Iniciar Sessão'
    expect(page).to have_content "Olá, #{user.description}"
    end
    expect(page).to have_content "Login efetuado com sucesso."
  end
  it 'e faz logout' do
    # Arrange
    user = FactoryBot.create(:user)

    # Act
    login_as(user)
    visit root_path
    click_on 'Encerrar Sessão'

    # Assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Iniciar Sessão'
  end
end
