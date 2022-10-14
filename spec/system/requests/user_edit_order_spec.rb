require 'rails_helper'

describe 'Usuário tenta editar parametro de uma ordem de serviço e não é administrador' do
  it '(status)' do
    # Arrange
    user = FactoryBot.create(:user)

    order = FactoryBot.create(:order)

    login_as(user)
    patch(order_path(order), params: { order: { status: :canceled}})

    expect(response).to redirect_to(root_path)
  end
  it '(código)' do
    user = FactoryBot.create(:user)

    order = FactoryBot.create(:order)

    login_as(user)
    patch(order_path(order), params: { order: { code: 'AJD02J304I102O3'}})

    expect(response).to redirect_to(root_path)
  end
end
