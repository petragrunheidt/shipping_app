class OrderEndsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @order_end = OrderEnd.new
  end

  def create
    @order = Order.find(params[:order_id])
    order_end_params = params.require(:order_end).permit(:time, :reason)

    @order_end = OrderEnd.new(order_end_params)
    @order_end.order = @order
    @vehicle = @order.order_start.vehicle

    if @order_end.save
      @order.delivered!
      @vehicle.available!
      redirect_to @order, notice: 'Ordem de Serviço Finalizada.'
    else
      render :new
    end
  end
end
