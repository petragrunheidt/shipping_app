class VehiclesController < ApplicationController
  before_action :check_admin, only: [:new, :create, :edit, :update, :activate, :deactivate]
  before_action :set_transport_mode, only: [:new, :create, :edit, :update,]
  before_action :set_vehicle, only: [:show, :edit, :update, :activate, :deactivate]
  before_action :vehicle_params, only: [:create, :update]
  def index
    @vehicles = Vehicle.all
  end

  def show; end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      return redirect_to @vehicle, notice: 'Veículo Cadastrado com sucesso.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @vehicle.update(vehicle_params)
      return redirect_to @vehicle, notice: 'Veículo Atualizado com sucesso.'
    else
      render :new
    end
  end

  def activate
    @vehicle.available!
    return redirect_to @vehicle, notice: 'Veículo ativado para circulação.'
  end

  def deactivate
    @vehicle.maintenance!
    return redirect_to @vehicle, notice: 'Veículo enviado para manutenção.'
  end

  def search
    @query = params["query"]
    @vehicles = Vehicle.where("nameplate LIKE ?", "%#{@query}%")
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:nameplate, :vehicle_brand, :vehicle_model,
      :manifacture_year, :maximum_load, :transport_mode_id, :status)
  end

  def check_admin

    if !current_user.admin
      return redirect_to root_path, notice: "Acesso negado"
    end
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def set_transport_mode
    @transport_modes = TransportMode.all
  end
end

