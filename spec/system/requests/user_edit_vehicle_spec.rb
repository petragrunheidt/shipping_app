require 'rails_helper'

describe 'Usuário tenta editar parametro de um veículo' do
  context 'edit valid params values' do
    it '(status) e não é administrador' do
        # Arrange
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode)
        vehicle = Vehicle.create(nameplate: 'ABC1234', vehicle_brand: 'Nissan', vehicle_model: 'A140i',
                        manifacture_year: 2005, maximum_load: 100, transport_mode: trans, status: :maintenance)
        # Act
        login_as(user)
        patch(transport_mode_path(vehicle), params: { vehicle: { status: :circulation}})
        # Assert
        expect(response).to redirect_to(root_path)
      end
      it '(nameplate) e não é administrador' do
        # Arrange
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode)
        vehicle = Vehicle.create(nameplate: 'ABC1234', vehicle_brand: 'Nissan', vehicle_model: 'A140i',
                        manifacture_year: 2005, maximum_load: 100, transport_mode: trans, status: :maintenance)
        # Act
        login_as(user)
        patch(transport_mode_path(vehicle), params: { vehicle: { nameplate: 'ICN4930'}})
        # Assert
        expect(response).to redirect_to(root_path)
      end
      it '(vehicle_brand) e não é administrador' do
        # Arrange
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode)
        vehicle = Vehicle.create(nameplate: 'ABC1234', vehicle_brand: 'Nissan', vehicle_model: 'A140i',
                        manifacture_year: 2005, maximum_load: 100, transport_mode: trans, status: :maintenance)
        # Act
        login_as(user)
        patch(transport_mode_path(vehicle), params: { vehicle: { vehicle_brand: 'Ford'}})
        # Assert
        expect(response).to redirect_to(root_path)
      end
      it '(vehicle_model) e não é administrador' do
        # Arrange
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode)
        vehicle = Vehicle.create(nameplate: 'ABC1234', vehicle_brand: 'Nissan', vehicle_model: 'A140i',
                        manifacture_year: 2005, maximum_load: 100, transport_mode: trans, status: :maintenance)
        # Act
        login_as(user)
        patch(transport_mode_path(vehicle), params: { vehicle: { vehicle_model: 'B394'}})
        # Assert
        expect(response).to redirect_to(root_path)
      end
      it '(manifacture_year) e não é administrador' do
        # Arrange
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode)
        vehicle = Vehicle.create(nameplate: 'ABC1234', vehicle_brand: 'Nissan', vehicle_model: 'A140i',
                        manifacture_year: 2005, maximum_load: 100, transport_mode: trans, status: :maintenance)
        # Act
        login_as(user)
        patch(transport_mode_path(vehicle), params: { vehicle: { manifacture_year: 1990}})
        # Assert
        expect(response).to redirect_to(root_path)
      end
      it '(maximum_load) e não é administrador' do
        # Arrange
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode)
        vehicle = Vehicle.create(nameplate: 'ABC1234', vehicle_brand: 'Nissan', vehicle_model: 'A140i',
                        manifacture_year: 2005, maximum_load: 100, transport_mode: trans, status: :maintenance)
        # Act
        login_as(user)
        patch(transport_mode_path(vehicle), params: { vehicle: { maximum_load: 80}})
        # Assert
        expect(response).to redirect_to(root_path)
      end
      it '(maximum_load) e não é administrador' do
        # Arrange
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode)
        transb = FactoryBot.create(:transport_mode)
        vehicle = Vehicle.create(nameplate: 'ABC1234', vehicle_brand: 'Nissan', vehicle_model: 'A140i',
                        manifacture_year: 2005, maximum_load: 100, transport_mode: trans, status: :maintenance)
        # Act
        login_as(user)
        patch(transport_mode_path(vehicle), params: { vehicle: { transport_mode: transb}})
        # Assert
        expect(response).to redirect_to(root_path)
      end
  end    
end