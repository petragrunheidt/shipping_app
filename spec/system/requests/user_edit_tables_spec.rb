require 'rails_helper'

describe 'Usuário tenta editar parametro da tabela' do
  context 'de peso e edita parametros com informações válidas' do
    it '(min) e não é administrador' do       
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode, min_weight: 5, max_weight: 200)
        weight_table = FactoryBot.create(:weight_table, min: 10, max: 100, value: 0.5, transport_mode: trans)
        
        login_as(user)
        patch(transport_mode_path(weight_table), params: { weight_table: { min: 20}})
        
        expect(response).to redirect_to(root_path)
      end
      it '(max) e não é administrador' do
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode, min_weight: 5, max_weight: 200)
        weight_table = FactoryBot.create(:weight_table, min: 10, max: 100, value: 0.5, transport_mode: trans)
        
        login_as(user)
        patch(transport_mode_path(weight_table), params: { weight_table: { max: 80}})
        
        expect(response).to redirect_to(root_path)
      end
      it '(value) e não é administrador' do
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode, min_weight: 5, max_weight: 200)
        weight_table = FactoryBot.create(:weight_table, min: 10, max: 100, value: 0.5, transport_mode: trans)
        
        login_as(user)
        patch(transport_mode_path(weight_table), params: { weight_table: { value: 0.1}})
        
        expect(response).to redirect_to(root_path)
      end
      it '(transport_mode) e não é administrador' do
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode, min_weight: 5, max_weight: 200)
        transb = FactoryBot.create(:transport_mode, min_weight: 2, max_weight: 180)
        weight_table = FactoryBot.create(:weight_table, min: 10, max: 100, value: 0.5, transport_mode: trans)
        
        login_as(user)
        patch(transport_mode_path(weight_table), params: { weight_table: { transport_mode: transb}})
        
        expect(response).to redirect_to(root_path)
      end
  end    
  context 'de distância e edita parametros com informações válidas' do
    it '(min) e não é administrador' do       
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode, min_distance: 5, max_distance: 200)
        distance_table = FactoryBot.create(:distance_table, min: 10, max: 100, value: 0.5, transport_mode: trans)
        
        login_as(user)
        patch(transport_mode_path(distance_table), params: { distance_table: { min: 20}})
        
        expect(response).to redirect_to(root_path)
      end
      it '(max) e não é administrador' do
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode, min_distance: 5, max_distance: 200)
        distance_table = FactoryBot.create(:distance_table, min: 10, max: 100, value: 0.5, transport_mode: trans)
        
        login_as(user)
        patch(transport_mode_path(distance_table), params: { distance_table: { max: 80}})
        
        expect(response).to redirect_to(root_path)
      end
      it '(value) e não é administrador' do
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode, min_distance: 5, max_distance: 200)
        distance_table = FactoryBot.create(:distance_table, min: 10, max: 100, value: 0.5, transport_mode: trans)
        
        login_as(user)
        patch(transport_mode_path(distance_table), params: { distance_table: { value: 80}})
        
        expect(response).to redirect_to(root_path)
      end
      it '(transport_mode) e não é administrador' do
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode, min_distance: 5, max_distance: 200)
        transb = FactoryBot.create(:transport_mode, min_distance: 2, max_distance: 180)
        distance_table = FactoryBot.create(:distance_table, min: 10, max: 100, value: 0.5, transport_mode: trans)
        
        login_as(user)
        patch(transport_mode_path(distance_table), params: { distance_table: { transport_mode: transb}})
        
        expect(response).to redirect_to(root_path)
      end
  end
  context 'de prazos e edita parametros com informações válidas' do
    it '(min) e não é administrador' do       
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode, min_distance: 5, max_distance: 200)
        deadline = FactoryBot.create(:deadline, min: 10, max: 100, time: 24, transport_mode: trans)
        
        login_as(user)
        patch(transport_mode_path(deadline), params: { deadline: { min: 20}})
        
        expect(response).to redirect_to(root_path)
      end
      it '(max) e não é administrador' do
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode, min_distance: 5, max_distance: 200)
        deadline = FactoryBot.create(:deadline, min: 10, max: 100, time: 24, transport_mode: trans)
        
        login_as(user)
        patch(transport_mode_path(deadline), params: { deadline: { max: 80}})
        
        expect(response).to redirect_to(root_path)
      end
      it '(time) e não é administrador' do
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode, min_distance: 5, max_distance: 200)
        deadline = FactoryBot.create(:deadline, min: 10, max: 100, time: 24, transport_mode: trans)
        
        login_as(user)
        patch(transport_mode_path(deadline), params: { deadline: { time: 600}})
        
        expect(response).to redirect_to(root_path)
      end
      it '(transport_mode) e não é administrador' do
        user = FactoryBot.create(:user)
        trans = FactoryBot.create(:transport_mode, min_distance: 5, max_distance: 200)
        transb = FactoryBot.create(:transport_mode, min_distance: 2, max_distance: 180)
        deadline = FactoryBot.create(:deadline, min: 10, max: 100, time: 24, transport_mode: trans)
        
        login_as(user)
        patch(transport_mode_path(deadline), params: { deadline: { transport_mode: transb}})
        
        expect(response).to redirect_to(root_path)
      end
  end
end