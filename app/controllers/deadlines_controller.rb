class DeadlinesController < ApplicationController
  before_action :check_admin, only: [:new, :create, :edit, :update]
  before_action :set_deadline, only: [:edit, :update]
  before_action :deadline_params, only: [:create, :update]
  def new
    @transport_modes = TransportMode.all
    @deadline = Deadline.new

  end

  def create
    @transport_mode = TransportMode.find(params[:transport_mode_id])
    @deadline = Deadline.new(deadline_params)

    @deadline.transport_mode = @transport_mode
    if @deadline.save
      return redirect_to @deadline.transport_mode, notice: "Linha da tabela de prazos adicionada com sucesso."
    else
      return redirect_to @transport_mode, alert: 'Todos os dados da tabela de prazos devem ser preenchidos'
    end
  end

  def edit
    @transport_mode = TransportMode.find(params[:transport_mode_id])
    @transport_modes = TransportMode.all

  end

  def update
    @transport_mode = TransportMode.find(params[:transport_mode_id])
    @transport_modes = TransportMode.all
    if @deadline.update(deadline_params)
      return redirect_to @deadline.transport_mode, notice: "Linha da tabela de prazos editada com sucesso."
    else
      render :edit
    end
  end

  private

  def deadline_params
    params.require(:deadline).permit(:min, :max, :time)
  end

  def set_deadline
    @deadline = Deadline.find(params[:id])

  end
end
