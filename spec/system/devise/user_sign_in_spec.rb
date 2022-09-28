require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Petra', email: 'petra@petramail.com', password: 'password')
    # Act
    visit root_path
    click_on 'Iniciar Sessão'
    fill_in 'E-mail', with: 'petra@petramail.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'

    # Assert
    within('nav') do
    expect(page).to have_button 'Encerrar Sessão'
    expect(page).not_to have_link 'Iniciar Sessão'
    expect(page).to have_content "Olá, #{user.email}"
    end
    expect(page).to have_content "Login efetuado com sucesso."
  end
end
