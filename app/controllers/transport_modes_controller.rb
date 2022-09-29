class TransportModesController < ApplicationController
  before_action :check_admin, only: [:new, :create, :edit, :update]
  before_action :set_transport_mode, only: [:show, :edit, :update]
  before_action :transport_mode_params, only: [:create, :update]
  def index
    @transport_mode = TransportMode.all
  end

  def show; end

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
      render :new
    end
  end


  private

  def transport_mode_params
    params.require(:transport_mode).permit(:name, :min_distance,
      :max_distance, :min_weight, :max_weight, :shipping_value)
  end

  def check_admin

    if !current_user.admin
      return redirect_to root_path, notice: "Acesso negado"
    end
  end

  def set_transport_mode
    @transport_mode = TransportMode.find(params[:id])
  end
end
