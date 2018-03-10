require 'rails_helper'

RSpec.describe User, type: :model do

  it "is valid with a username and password" do
    user = User.new(username: "username", password: "password")

    expect(user.valid?).to eq(true)
  end

  it "is invalid without a username" do
    user = User.new(password: "password")

    expect(user.valid?).to eq(false)
    expect(user.errors.messages[:username]).to include("can't be blank")
  end

  it "is invalid with a username less than 4 characters long" do
    user = User.new(username: "abc", password: "password")

    expect(user.valid?).to eq(false)
    expect(user.errors.messages[:username]).to include("is too short (minimum is 4 characters)")
  end

  it "is invalid with a username more than 20 characters long" do
    user = User.new(username: "u" * 21, password: "password")

    expect(user.valid?).to eq(false)
    expect(user.errors.messages[:username]).to include("is too long (maximum is 20 characters)")
  end

  it "is invalid with a non-unique username" do
    user = User.create(username: "username", password: "password")
    user = User.new(username: "username", password: "anything")

    expect(user.valid?).to eq(false)
    expect(user.errors.messages[:username]).to include("has already been taken")
  end

  it "is invalid without a password" do
    user = User.new(username: "username")

    expect(user.valid?).to eq(false)
    expect(user.errors.messages[:password]).to include("can't be blank")
  end

  it "is invalid with a password under 8 characters long" do
    user = User.new(username: "username", password: "short")

    expect(user.valid?).to eq(false)
    expect(user.errors.messages[:password]).to include("is too short (minimum is 8 characters)")
  end

  it "is invalid with a password over 20 characters long" do
    user = User.new(username: "username", password: "u" * 21)

    expect(user.valid?).to eq(false)
    expect(user.errors.messages[:password]).to include("is too long (maximum is 20 characters)")
  end

  it "returns false for authenticated? for a user with nil digest" do
    user = User.create(username: "username", password: "password")
    expect(user.authenticated?('comparisondigest')).to be(false)
  end
end
