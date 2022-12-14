class VehiclesController < ApplicationController
  before_action :check_admin, only: %i[new create edit update activate deactivate]
  before_action :set_transport_mode, only: %i[new create edit update]
  before_action :set_vehicle, only: %i[show edit update activate deactivate]
  before_action :vehicle_params, only: %i[create update]
  def index
    @transport_modes = TransportMode.all
    @vehicles = Vehicle.all
  end

  def show; end

  def new
    @vehicle = Vehicle.new
  end

  def edit; end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    return redirect_to @vehicle, notice: 'Veículo Cadastrado com sucesso.' if @vehicle.save

    render :new
  end

  def update
    return redirect_to @vehicle, notice: 'Veículo Atualizado com sucesso.' if @vehicle.update(vehicle_params)

    render :edit
  end

  def activate
    @vehicle.available!
    redirect_to @vehicle, notice: 'Veículo ativado para circulação.'
  end

  def deactivate
    @vehicle.maintenance!
    redirect_to @vehicle, notice: 'Veículo enviado para manutenção.'
  end

  def search
    @query = params['query']
    @vehicles = Vehicle.where('nameplate LIKE ?', "%#{@query}%")
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:nameplate, :vehicle_brand, :vehicle_model,
                                    :manifacture_year, :maximum_load, :transport_mode_id, :status)
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def set_transport_mode
    @transport_modes = TransportMode.all
  end
end
