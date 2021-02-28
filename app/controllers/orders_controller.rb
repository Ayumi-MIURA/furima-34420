class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]

  def index
    @address = Address.new
  end

  def create
  
    @address = Address.new(address_params)
    if @address.valid?
      @address.save
      redirect_to :index
    else
      render :index
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
    ).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
