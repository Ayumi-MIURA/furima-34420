class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destory]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :different_current_user, only: [:edit, :update, :destroy]

  def index
    @item = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :image,
      :title,
      :description,
      :category_id,
      :item_status_id,
      :shipping_fee_id,
      :prefecture_id,
      :shipping_day_id,
      :price
    ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def different_current_user
    @item = Item.find(params[:id])
    redirect_to action: :index unless current_user.id == @item.user_id
  end
end
