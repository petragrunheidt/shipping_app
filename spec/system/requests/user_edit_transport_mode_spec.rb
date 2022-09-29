require 'rails_helper'

describe 'Usuário tenta editar parametros de um modo de transporte' do
  it 'e não é administrador' do
    # Arrange
    user = FactoryBot.create(:user)

    trans = FactoryBot.create(:transport_mode)
    # Act
    login_as(user)
    patch(transport_mode_path(trans), params: { transport_mode: { status: 1}})
    # Assert
    expect(response).to redirect_to(root_path)
  end
end
