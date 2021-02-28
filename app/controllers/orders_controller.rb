class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @address = Address.new
  end

  def create
    @address = Address.new(order_params)
    if @address.valid?
      @address.save
      redirect_to action :index
    else
      render action :index
    end
  end

  private

  def address_params
    params.require(:address).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :address,
      :building,
      :phone_number,
    ).marge(user_id: current_user.id, item_id: params[:item_id])
  end
end
