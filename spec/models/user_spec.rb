require 'rails_helper'

describe User do
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is valid with a first name, last name, email and password" do
    user = User.new(
      first_name: "Sterling",
      last_name: "Archer",
      email: "archer@example.gov",
      password: "sploosh1",
    )

    expect(user).to be_valid
  end

  it "is invalid without a first name" do
    user1 = FactoryBot.build(:user, first_name: nil)
    user2 = FactoryBot.build(:user, first_name: "")

    expect(user1).to_not be_valid
    expect(user2).to_not be_valid
  end

  it "is invalid without a last name" do
    user1 = FactoryBot.build(:user, last_name: nil)
    user2 = FactoryBot.build(:user, last_name: "")

    expect(user1).to_not be_valid
    expect(user2).to_not be_valid
  end

  it "is invalid without a email name" do
    user1 = FactoryBot.build(:user, email: nil)
    user2 = FactoryBot.build(:user, email: "")

    expect(user1).to_not be_valid
    expect(user2).to_not be_valid
  end

  it "is invalid with a duplicate email address in database" do
    User.create(
      first_name: "Sterling",
      last_name: "Archer",
      email: "archer@example.gov",
      password: "sploosh1",
    )

    user = User.new(
      first_name: "Sterling",
      last_name: "Archer",
      email: "archer@example.gov",
      password: "sploosh1",
    )

    expect(user).to_not be_valid
  end

  it "is invalid without a password" do
    user1 = FactoryBot.build(:user, password: nil)
    user2 = FactoryBot.build(:user, password: "")

    expect(user1).to_not be_valid
    expect(user2).to_not be_valid
  end

  it "should be invalid with a password that does not fit regex requirements"

  it "returns a contact's full name as a string" do
    user = User.new(
      first_name: "Sterling",
      last_name: "Archer",
      email: "archer@example.gov",
      password: "sploosh1",
    )

    expect(user.name).to eq("Sterling Archer")
  end

  it "should have many houses"
  it "should authenticate"

  # it { should have_many :houses }
  # it { should_not have_valid(:password).when("1234567") }
  # it "authenticates a user" do
  #   user = User.create!(email: "name@example.com", password: "password")
  #   expect(user.authenticate("not_the_right_password")).to eq(false)
  #   expect(user.authenticate("password")).to eq(user)
  #   expect(!!user.authenticate("password")).to eq(true)
  # end
end
