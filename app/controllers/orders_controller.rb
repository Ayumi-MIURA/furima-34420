class OrdersController < ApplicationController
  def index
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      @order.save
      redirect_to action :index
    else
      render action :index
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :postal_code,
      :prefecture_id
      :city,
      :address,
      :building,
      :phone_number
    )
  end
end
