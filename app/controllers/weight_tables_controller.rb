class WeightTablesController < ApplicationController
  before_action :check_admin, only: [:new, :create, :edit, :update]
  before_action :set_weight_line, only: [:edit, :update]
  before_action :weight_line_params, only: [:create, :update]

  def new
    @last_line = WeightTable.last
    @weight_line = WeightTable.new
    @transport_modes = TransportMode.all
  end

  def create
    @transport_modes = TransportMode.all
    @weight_line = WeightTable.new(weight_line_params)
    if @weight_line.save
      return redirect_to @weight_line.transport_mode, notice: "Linha #{@weight_line.id} adicionada com sucesso."
    else
      render :new
    end
  end

  def edit
    @transport_modes = TransportMode.all
    @previous = @weight_line.previous
    @next = @weight_line.next
  end

  def update
    @transport_modes = TransportMode.all
    if @weight_line.update(weight_line_params)
      return redirect_to @weight_line.transport_mode, notice: "Linha #{@weight_line.id} editada com sucesso."
    else
      render :new
    end
  end

  private

  def weight_line_params
    params.require(:weight_table).permit(:min, :max, :value, :transport_mode_id)
  end

  def check_admin

    if !current_user.admin
      return redirect_to root_path, notice: "Acesso negado"
    end
  end

  def set_weight_line
    @weight_line = WeightTable.find(params[:id])
  end

end
