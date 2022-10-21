class TransportModesController < ApplicationController
  before_action :check_admin, only: [:new, :create, :edit, :update, :activate, :deactivate]
  before_action :set_transport_mode, only: [:show, :edit, :update, :activate, :deactivate]
  before_action :transport_mode_params, only: [:create, :update]

  def index
    @transport_mode = TransportMode.all
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

  def create
    @transport_mode = TransportMode.new(transport_mode_params)
    if @transport_mode.save
      return redirect_to @transport_mode, notice: 'Modo de Transporte Cadastrado com sucesso.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @transport_mode.update(transport_mode_params)
      return redirect_to @transport_mode, notice: 'Modo de Transporte Atualizado com sucesso.'
    else
      render :edit
    end
  end

  def activate
    return redirect_to @transport_mode, notice: 'Modo de Transporte não pode ser ativado com tabela de peso em branco' if @transport_mode.weight_tables.empty?
    return redirect_to @transport_mode, notice: 'Modo de Transporte não pode ser ativado com tabela de distância em branco' if @transport_mode.distance_tables.empty?
    return redirect_to @transport_mode, notice: 'Modo de Transporte não pode ser ativado com tabela de prazos em branco' if  @transport_mode.deadlines.empty?
    @transport_mode.active!
    return redirect_to @transport_mode, notice: 'Modo de Transporte ativado.'
  end

  def deactivate
    @transport_mode.inactive!
    return redirect_to @transport_mode, notice: 'Modo de Transporte desativado.'
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
