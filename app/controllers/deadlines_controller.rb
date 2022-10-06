class DeadlinesController < ApplicationController
  before_action :check_admin, only: [:new, :create, :edit, :update]
  before_action :set_deadline, only: [:edit, :update]
  before_action :deadline_params, only: [:create, :update]
  def new
    @transport_modes = TransportMode.all
    @deadline = Deadline.new

  end

  def create
    @transport_modes = TransportMode.all
    @deadline = Deadline.new(deadline_params)
    if @deadline.save
      return redirect_to @deadline.transport_mode, notice: "Linha #{@deadline.id} adicionada com sucesso."
    else
      render :new
    end
  end

  def edit
    @transport_modes = TransportMode.all

  end

  def update
    @transport_modes = TransportMode.all
    if @deadline.update(deadline_params)
      return redirect_to @deadline.transport_mode, notice: "Linha #{@deadline.id} editada com sucesso."
    else
      render :new
    end
  end

  private

  def deadline_params
    params.require(:deadline).permit(:min, :max, :time, :transport_mode_id)
  end

  def check_admin

    if !current_user.admin
      return redirect_to root_path, notice: "Acesso negado"
    end
  end

  def set_deadline
    @deadline = Deadline.find(params[:id])

  end
end
