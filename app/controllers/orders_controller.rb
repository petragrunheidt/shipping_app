class OrdersController < ApplicationController
  before_action :check_admin, only: [:new, :create, :edit, :update, :set_pending, :set_canceled, :set_delivered]
  before_action :set_order, only: [:show, :edit, :update, :set_pending, :set_canceled, :set_delivered]
  before_action :order_params, only: [:create, :update]
  def index
    @orders = Order.all
  end

  def show
    @order_confirmation = OrderStart.find_by(order: @order)
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      return redirect_to @order, notice: 'Ordem de Serviço cadastrada com sucesso.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @order.update(order_params)
      return redirect_to @order, notice: 'Ordem de Serviço atualizado com sucesso.'
    else
      render :new
    end
  end

  def set_on_route
    @order.on_route!
    return redirect_to @order, notice: "Status da ordem de serviço atualizada."
  end

  def set_delivered
    @order.delivered!
    return redirect_to @order, notice: "Status da ordem de serviço atualizada."
  end

  def set_canceled
    @order.canceled!
    return redirect_to @order, notice: "Status da ordem de serviço atualizada."
  end

  private

  def order_params
    params.require(:order).permit(:takeout_address, :weight, :heigth, :width, :depth, :delivery_address, :name,
      :email, :customer_id, :total_distance, :status, :code)
  end

  def check_admin

    if !current_user.admin
      return redirect_to root_path, notice: "Acesso negado"
    end
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
