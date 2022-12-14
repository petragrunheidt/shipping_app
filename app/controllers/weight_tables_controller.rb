class WeightTablesController < ApplicationController
  before_action :check_admin, only: %i[new create edit update]
  before_action :set_weight_line, only: %i[edit update]
  before_action :weight_line_params, only: %i[create update]

  def new
    @weight_line = WeightTable.new
    @transport_modes = TransportMode.all
  end

  def edit
    @transport_mode = TransportMode.find(params[:transport_mode_id])
    @transport_modes = TransportMode.all
  end

  def create
    @transport_mode = TransportMode.find(params[:transport_mode_id])

    @weight_line = WeightTable.new(weight_line_params)
    @weight_line.transport_mode = @transport_mode
    if @weight_line.save
      return redirect_to @weight_line.transport_mode, notice: 'Linha da tabela de peso adicionada com sucesso.'
    end

    redirect_to @transport_mode, alert: @weight_line.errors.full_messages
  end

  def update
    @transport_mode = TransportMode.find(params[:transport_mode_id])
    @transport_modes = TransportMode.all
    if @weight_line.update(weight_line_params)
      return redirect_to @weight_line.transport_mode, notice: 'Linha da tabela de peso editada com sucesso.'
    end

    render :edit
  end

  private

  def weight_line_params
    params.require(:weight_table).permit(:min, :max, :value)
  end

  def set_weight_line
    @weight_line = WeightTable.find(params[:id])
  end
end
