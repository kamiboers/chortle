require 'rails_helper'

RSpec.describe User, type: :model do

  it "is valid with a username and password" do
    user = User.new(username: "username", password: "password")

    expect(user.valid?).to eq(true)
  end

  it "is invalid without a username" do
    user = User.new(password: "password")

    expect(user.valid?).to eq(false)
  end

  it "is invalid without a password" do
    user = User.new(username: "username")

    expect(user.valid?).to eq(false)
  end
end
