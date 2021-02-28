class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :different_current_user, only: [:index]

  def index
    @user_order = UserOrder.new

  end

  def create
    @user_order = UserOrder.new(order_params)
    if @user_order.valid?
      @user_order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:user_order).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :address,
      :building,
      :phone_number,
    ).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def different_current_user
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end
end
