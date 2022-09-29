require 'rails_helper'

describe 'Usuário acessa a pagina de admin' do
  it 'com sucesso' do
    # Arrange
    admin = FactoryBot.create(:user, admin: true)
    # Act
    login_as(admin)
    visit admin_dashboard_index_path

    # Assert
    expect(current_path).to eq admin_dashboard_index_path
    expect(page).to have_content "Pagina de Administradores"
  end
  it 'como um usuário comum e é redirecionado para a pagina inicial' do
    # Arrange
    user = FactoryBot.create(:user, admin: false)
    # Act
    login_as(user)
    visit admin_dashboard_index_path

    # Assert
    expect(current_path).to eq root_path
    expect(page).not_to have_content "Pagina de Administradores"
  end
end
