require 'rails_helper'

describe User do
  it { should have_many :houses }

  it { should have_valid(:email).when("name@example.com") }
  it { should_not have_valid(:email).when(nil, "") }
  it "does not allow duplicate emails in user table" do
    User.create!(email: "name@example.com", password: "password")
    user = User.new
    user.email = "name@example.com"
    expect(user).to_not be_valid
    user.email = user.email.upcase
    expect(user).to_not be_valid
  end

  it { should_not have_valid(:password).when(nil, "") }
  it { should_not have_valid(:password).when("1234567") }
  it "authenticates a user" do
    user = User.create!(email: "name@example.com", password: "password")
    expect(user.authenticate("not_the_right_password")).to eq(false)
    expect(user.authenticate("password")).to eq(user)
    expect(!!user.authenticate("password")).to eq(true)
  end

  it "returns a contact's full name as a string" do
    user = User.create!(email: "name@example.com", password: "password", first_name: "Sterling", last_name: "Archer")
    expect(user.name).to eq("Sterling Archer")
  end

end
