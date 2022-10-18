require 'rails_helper'

describe 'Usuário tenta editar parametro de um modo de transporte' do
  it '(status) e não é administrador' do
    # Arrange
    user = FactoryBot.create(:user)

    trans = FactoryBot.create(:transport_mode, status: :inactive)
    # Act
    login_as(user)
    patch(transport_mode_path(trans), params: { transport_mode: { status: :active}})
    # Assert
    expect(response).to redirect_to(root_path)
  end
end
