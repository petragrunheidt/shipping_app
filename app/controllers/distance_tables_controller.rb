class DistanceTablesController < ApplicationController
  before_action :check_admin, only: [:new, :create, :edit, :update]
  before_action :set_distance_line, only: [:edit, :update]
  before_action :distance_line_params, only: [:create, :update]
  def new
    @transport_modes = TransportMode.all
    @distance_line = DistanceTable.new

  end

  def create
    @transport_mode = TransportMode.find(params[:transport_mode_id])

    @distance_line = DistanceTable.new(distance_line_params)
    @distance_line.transport_mode = @transport_mode
    if @distance_line.save
      return redirect_to @distance_line.transport_mode, notice: "Linha #{@distance_line.id} adicionada com sucesso."
    else
      render :new
    end
  end

  def edit
    @transport_mode = TransportMode.find(params[:transport_mode_id])
    @transport_modes = TransportMode.all

  end

  def update
    @transport_mode = TransportMode.find(params[:transport_mode_id])
    @transport_modes = TransportMode.all
    if @distance_line.update(distance_line_params)
      return redirect_to @distance_line.transport_mode, notice: "Linha #{@distance_line.id} editada com sucesso."
    else
      render :new
    end
  end

  private

  def distance_line_params
    params.require(:distance_table).permit(:min, :max, :value)
  end

  def check_admin

    if !current_user.admin
      return redirect_to root_path, notice: "Acesso negado"
    end
  end

  def set_distance_line
    @distance_line = DistanceTable.find(params[:id])
    @previous_line = @distance_line.next
    @next_line = @distance_line.previous
  end
end
