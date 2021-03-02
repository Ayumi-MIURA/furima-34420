require 'rails_helper'

RSpec.describe UserOrder, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @user_order = FactoryBot.build(:user_order, user_id: @user.id , item_id: @item.id)
    sleep 0.1
  end

  describe '商品購入' do
    context '商品の購入が出来る場合' do
      it '全ての情報が正しく入力されていれば登録できる' do
        expect(@user_order).to be_valid
      end

      it 'buildingが空でも購入可能' do
        @user_order.building = ''
        expect(@user_order).to be_valid
      end
    end

    context '商品の購入が出来ない場合' do
      it 'postal_codeが空だと購入不可' do
        @user_order.postal_code = ''
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが半角のハイフンを含めないと購入不可' do
        @user_order.postal_code = '1234567'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'prefecture_idが0だと購入不可' do
        @user_order.prefecture_id = 0
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include('Prefecture must be other than 0')
      end

      it 'cityが空だと購入不可' do
        @user_order.city = ''
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("City can't be blank")
      end

      it 'addressが空だと購入不可' do
        @user_order.address = ''
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_numberが空だと購入不可' do
        @user_order.phone_number = ''
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが12桁以上だと購入不可' do
        @user_order.phone_number = '123456789012'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end

      it 'phone_numberが英数字混合だと購入不可' do
        @user_order.phone_number = 'abc123456789'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include('Phone number is invalid')
      end

      it 'tokenが空では購入不可' do
        @user_order.token = ''
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空では購入不可' do
        @user_order.user_id = ''
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では購入不可' do
        @user_order.item_id = ''
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
