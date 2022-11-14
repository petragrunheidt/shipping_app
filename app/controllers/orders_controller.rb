class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show search]
  before_action :check_admin, only: %i[new create edit update set_pending set_canceled set_delivered]
  before_action :set_order,
                only: %i[show edit update set_pending set_canceled set_delivered order_confirmation]
  before_action :order_params, only: %i[create update]
  def index
    @orders = Order.all
  end

  def show
    @order_confirmation = OrderStart.find_by(order: @order)
  end

  def new
    @order = Order.new
  end

  def edit; end

  def create
    @order = Order.new(order_params)
    return redirect_to @order, notice: 'Ordem de Serviço cadastrada com sucesso.' if @order.save

    render :new
  end

  def update
    return redirect_to @order, notice: 'Ordem de Serviço atualizada com sucesso.' if @order.update(order_params)

    render :edit
  end

  def search
    @order_query = params['order_query']
    @order = Order.find_by(code: @order_query)
  end

  def order_confirmation
    @order.on_route!
    @order.order_start.vehicle.out_for_delivery!
    redirect_to @order, notice: 'Ordem de Serviço confirmada.'
  end

  def set_delivered
    @order.delivered!
    redirect_to @order, notice: 'Status da ordem de serviço atualizada.'
  end

  def set_canceled
    @order.canceled!
    @order.order_start.vehicle.available!
    redirect_to @order, notice: 'Status da ordem de serviço atualizada.'
  end

  private

  def order_params
    params.require(:order).permit(:takeout_address, :weight, :heigth, :width, :depth, :delivery_address, :name,
                                  :email, :customer_id, :total_distance, :status, :code)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
