require 'rails_helper'

describe 'Usuário cria sua conta' do
  it 'com sucesso' do
    # Arrange

    # Act
    visit new_user_session_path
    click_on "Criar uma conta"
    fill_in 'Nome', with: 'Petrinha'
    fill_in 'E-mail', with: 'petrinha@gmail.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'

    # Assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
  end
end
