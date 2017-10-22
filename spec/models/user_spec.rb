require 'rails_helper'

describe User do
  # it { should have_many :portfolios }

  it { should have_valid(:email).when("name@example.com") }
  it { should_not have_valid(:email).when(nil, "") }
  it "does not allow duplicate emails in user table" do
    User.create!(email: "name@example.com")
    user = User.new
    user.email = "name@example.com"
    expect(user).to_not be_valid
    user.email = user.email.upcase
    expect(user).to_not be_valid
  end

  it "is valid with valid attributes"

  it "returns a contact's full name as a string" do
    user = User.create!(email: "name@example.com", first_name: "Sterling", last_name: "Archer")
    expect(user.name).to eq("Sterling Archer")
  end

end
