require 'rails_helper'

RSpec.describe User, type: :model do

    describe 'ユーザー登録' do
      it "全ての項目が存在すれば登録できること" do
        user = build(:user)
        expect(user).to be_valid  # user.valid? が true になればパスする
      end

      it "姓がない場合、無効である" do
         user = User.new(
         last_name: nil,
         first_name: "test",
         kana_last_name: "test",
         kana_first_name: "test",
         nickname: "test",
         email: "test@example.com",
         password: "password",
         password_confirmation: "password"
         )
        user.valid?
        expect(user.errors[:last_name]).to include("を入力してください")
      end

      it "名がない場合、無効である" do
         user = User.new(
         last_name: "test",
         first_name: nil,
         kana_last_name: "test",
         kana_first_name: "test",
         nickname: "test",
         email: "test@example.com",
         password: "password",
         password_confirmation: "password"
         )
        user.valid?
        expect(user.errors[:first_name]).to include("を入力してください")
      end

      it "姓カナがない場合、無効である" do
         user = User.new(
         last_name: "test",
         first_name: "test",
         kana_last_name: nil,
         kana_first_name: "test",
         nickname: "test",
         email: "test@example.com",
         password: "password",
         password_confirmation: "password"
         )
        user.valid?
        expect(user.errors[:kana_last_name]).to include("を入力してください")
      end

      it "名カナがない場合、無効である" do
         user = User.new(
         last_name: "test",
         first_name: "test",
         kana_last_name: "test",
         kana_first_name: nil,
         nickname: "test",
         email: "test@example.com",
         password: "password",
         password_confirmation: "password"
         )
        user.valid?
        expect(user.errors[:kana_first_name]).to include("を入力してください")
      end

      it "ニックネームがない場合、無効である" do
         user = User.new(
         last_name: "test",
         first_name: "test",
         kana_last_name: "test",
         kana_first_name: "test",
         nickname: nil,
         email: "test@example.com",
         password: "password",
         password_confirmation: "password"
         )
        user.valid?
        expect(user.errors[:nickname]).to include("を入力してください")
      end

      it "メールアドレスがない場合、無効である" do
         user = User.new(
         last_name: "test",
         first_name: "test",
         kana_last_name: "test",
         kana_first_name: "test",
         nickname: "test",
         email: nil,
         password: "password",
         password_confirmation: "password"
         )
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      it "パスワードがない場合、無効である" do
         user = User.new(
         last_name: "test",
         first_name: "test",
         kana_last_name: "test",
         kana_first_name: "test",
         nickname: "test",
         email: "test@example.com",
         password: nil,
         password_confirmation: "password"
         )
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

      it "パスワードがない場合、無効である" do
         user = User.new(
         last_name: "test",
         first_name: "test",
         kana_last_name: "test",
         kana_first_name: "test",
         nickname: "test",
         email: "test@example.com",
         password: nil,
         password_confirmation: "password"
         )
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

      it "確認用パスワードが一致しない場合、無効である" do
         user = User.new(
         last_name: "test",
         first_name: "test",
         kana_last_name: "test",
         kana_first_name: "test",
         nickname: "test",
         email: "test@example.com",
         password: "password",
         password_confirmation: "assword"
         )
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end
    end
end