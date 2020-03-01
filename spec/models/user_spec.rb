require 'rails_helper'

RSpec.describe User, type: :model do
  # user_name、user、パスワードがあれば有効な状態であること
  it "is valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  # test "name should be present" do
  it "is invalid without a user_name" do
    user = FactoryBot.build(:user, user_name: nil)
    user.valid?
    expect(user.errors[:user_name]).to include("を入力してください")
  end
  # test "user_name should be present" do
  it "is invalid without a name" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end
  # test "name should not be too long" do
  it "is invalid with a too long name length" do
    user = FactoryBot.build(:user, name: "a" * 51)
    user.valid?
    expect(user.errors[:name]).to include("は50文字以内で入力してください")
  end
  # test "user_name should not be too long" do
  it "is invalid with a too long user_name length" do
    user = FactoryBot.build(:user, user_name: "a" * 51)
    user.valid?
    expect(user.errors[:user_name]).to include("は50文字以内で入力してください")
  end
  # test test "user_name should be unique" do
  it "is invalid with a duplicate user_name" do
    FactoryBot.create(:user, user_name: "example")
    user = FactoryBot.build(:user, user_name: "example")
    user.valid?
    expect(user.errors[:user_name]).to include("はすでに存在します")
  end
  # test "password should be present (nonblank)" do
  it "is invalid without a password" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end
  # test "password should have a minimum length" do
  it "is invalid with a password length >= 6" do
    user = FactoryBot.build(:user, password: "a" * 5)
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end
end
