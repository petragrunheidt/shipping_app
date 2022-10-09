class OrderStartsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @order_start = OrderStart.new
    @transport_modes = TransportMode.all
  end
  def create
    @order = Order.find(params[:order_id])
    order_start_params = params.require(:order_start).permit(:transport_mode_id)

    @order_start = OrderStart.new(order_start_params)
    @order_start.order = @order

    if @order_start.save
      @order.waiting_confirmation!
      redirect_to @order, notice: 'Ordem de Serviço Iniciada.'
    else
      render:new
    end
  end
end
