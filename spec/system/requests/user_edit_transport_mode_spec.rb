require 'rails_helper'

describe 'Usuário tenta editar parametro de um modo de transporte' do
  it '(status) e não é administrador' do
    # Arrange
    user = FactoryBot.create(:user)
    trans = FactoryBot.create(:transport_mode, status: :inactive, min_weight: 5, min_distance: 5, max_weight: 500, max_distance: 500)
    FactoryBot.create(:weight_table, min: 10, max:50, value: 1, transport_mode: trans)
    FactoryBot.create(:distance_table, min: 10, max:50, value: 10, transport_mode: trans)
    FactoryBot.create(:deadline, min: 10, max:50, time: 48, transport_mode: trans)
    # Act
    login_as(user)
    patch(transport_mode_path(trans), params: { transport_mode: { status: :active}})
    # Assert
    expect(response).to redirect_to(root_path)
  end
  it '(status) e faltam tabelas' do
    admin = FactoryBot.create(:user, admin: true)
    trans = FactoryBot.create(:transport_mode, status: :inactive, min_weight: 5, min_distance: 5, max_weight: 500, max_distance: 500)

    login_as(admin)
    patch(transport_mode_path(trans), params: { transport_mode: { status: :active}})

    expect(trans.status).to eq 'inactive'
  end
end
