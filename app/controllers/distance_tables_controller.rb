class DistanceTablesController < ApplicationController
  before_action :check_admin, only: %i[new create edit update]
  before_action :set_distance_line, only: %i[edit update]
  before_action :distance_line_params, only: %i[create update]
  def new
    @transport_modes = TransportMode.all
    @distance_line = DistanceTable.new
  end

  def edit
    @transport_mode = TransportMode.find(params[:transport_mode_id])
    @transport_modes = TransportMode.all
  end

  def create
    @transport_mode = TransportMode.find(params[:transport_mode_id])

    @distance_line = DistanceTable.new(distance_line_params)
    @distance_line.transport_mode = @transport_mode
    if @distance_line.save
      return redirect_to @distance_line.transport_mode, notice: 'Linha da tabela de distância adicionada com sucesso.'
    end

    redirect_to @transport_mode, alert: @distance_line.errors.full_messages
  end

  def update
    @transport_mode = TransportMode.find(params[:transport_mode_id])
    @transport_modes = TransportMode.all
    if @distance_line.update(distance_line_params)
      return redirect_to @distance_line.transport_mode, notice: 'Linha da tabela de distância editada com sucesso.'
    end

    render :edit
  end

  private

  def distance_line_params
    params.require(:distance_table).permit(:min, :max, :value)
  end

  def set_distance_line
    @distance_line = DistanceTable.find(params[:id])
  end
end
