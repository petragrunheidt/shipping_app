require 'rails_helper'

describe 'Usuário tenta editar parametro de uma ordem de serviço' do
  it '(status) e não é administrador' do
    # Arrange
    user = FactoryBot.create(:user)

    order = FactoryBot.create(:order)
    # Act
    login_as(user)
    patch(transport_mode_path(order), params: { order: { status: :canceled}})
    # Assert
    expect(response).to redirect_to(root_path)
  end
end
