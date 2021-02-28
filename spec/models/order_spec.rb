require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  describe '商品購入' do
    context '商品の購入が出来る場合' do
      it '全ての情報が正しく入力されていれば登録できる' do
        expect(@order).to be_valid
      end

      it 'buildingが空でも購入可能' do
        @order.building = ''
        expect(@order).to be_valid
      end
    end  

    context '商品の購入が出来ない場合' do
        it 'postal_codeが空だと購入不可' do
          @order.postal_code = ''
          @order.valid?
          expect(@order.errors.full_messages).to include("Postal code can't be blank")
        end

        it ''
    end
  end    
end
