class TransportModesController < ApplicationController
  before_action :check_admin, only: %i[new create edit update activate deactivate]
  before_action :set_transport_mode, only: %i[show edit update activate deactivate]
  before_action :transport_mode_params, only: %i[create update]

  def index
    @transport_modes = TransportMode.all
  end

  def show
    @transport_modes = TransportMode.all

    @weight_table = @transport_mode.weight_tables
    @weight_line = WeightTable.new

    @distance_table = @transport_mode.distance_tables
    @distance_line = DistanceTable.new

    @deadline = @transport_mode.deadlines
    @deadline_line = Deadline.new
  end

  def new
    @transport_mode = TransportMode.new
  end

  def edit; end

  def create
    @transport_mode = TransportMode.new(transport_mode_params)
    return redirect_to @transport_mode, notice: 'Modo de Transporte Cadastrado com sucesso.' if @transport_mode.save

    render :new
  end

  def update
    if @transport_mode.update(transport_mode_params)
      return redirect_to @transport_mode, notice: 'Modo de Transporte Atualizado com sucesso.'
    end

    render :edit
  end

  def activate
    @transport_mode.active!
    redirect_to @transport_mode, notice: 'Modo de Transporte ativado.'
  rescue StandardError
    redirect_to @transport_mode, alert: @transport_mode.errors.full_messages
  end

  def deactivate
    @transport_mode.inactive!
    redirect_to @transport_mode, notice: 'Modo de Transporte desativado.'
  end

  private

  def transport_mode_params
    params.require(:transport_mode).permit(:name, :min_distance,
                                           :max_distance, :min_weight, :max_weight, :fixed_rate)
  end

  def set_transport_mode
    @transport_mode = TransportMode.find(params[:id])
  end
end
