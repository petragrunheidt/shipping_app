class OrderStartsController < ApplicationController
  before_action :set_order
  before_action :check_if_order_ends_exists, only: [:destroy]
  def new

    @order_start = OrderStart.new
    @transport_modes = TransportMode.where(status: :active).where("max_weight > ?", @order.weight).where("min_weight < ?", @order.weight)

  end

  def create

    order_start_params = params.require(:order_start).permit(:transport_mode_id, :order_date)

    @order_start = OrderStart.new(order_start_params)
    @order_start.order = @order
    @order_start.vehicle = @order_start.transport_mode.vehicles.where(status: :available).find_by("maximum_load > ?", @order.weight)

    if @order_start.save
      @order.waiting_confirmation!
      redirect_to @order, notice: 'Ordem de Serviço Iniciada.'
    else
      render:new
    end
  end

  def destroy

    @order.pending!
    if @order.order_start.destroy
      return redirect_to @order, notice: "Inicie novamente a Ordem de Serviço."
    end
  end
  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def check_if_order_ends_exists
    if !@order.order_end.nil?
      return redirect_to root_path, notice: "Acesso negado"
    end
  end
end
