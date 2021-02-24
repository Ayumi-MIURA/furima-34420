require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録' do
    context '登録ができる場合' do
      it '全ての情報が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '登録ができない場合' do
      it 'ニックネームが空だと登録不可' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空だと登録不可' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'パスワードが空だと登録不可' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'last_nameが空だと登録不可' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'first_nameが空だと登録不可' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'last_name_kanaが空だと登録不可' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'first_name_kanaが空だと登録不可' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'birthdayが空だと登録不可' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      it '重複したメールアドレスがあると登録不可' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      
      it 'メールアドレスに＠がないと登録不可' do
        @user.email = "sample"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'パスワードが６文字以上でなければ登録不可' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードと確認用パスワードが一致していなければ登録不可' do
      @user.password = 'a12345'
        @user.password_confirmation = 'a12346'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'パスワードが英語のみでは登録不可' do
        @user.password = "aaaaaa"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'パスワードが数字のみでは登録不可' do
        @user.password = "111111"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'パスワードが全角では登録不可' do
        @user.password = "ａａａａａａ"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'last_name_kanaが半角だと登録不可' do
        @user.last_name_kana = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end

      it 'first_name_kanaが半角だと登録不可' do
        @user.first_name_kana = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end

    end
  end
end
