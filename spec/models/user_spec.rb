require 'rails_helper'

describe User do
  context "FactoryBot" do
    it "has a valid factory" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
  end

  context "validations" do
    it "is valid with a first name, last name, email and password" do
      user = User.new(
        first_name: "Sterling",
        last_name: "Archer",
        email: "archer@example.gov",
        password: "dutchess25",
      )

      expect(user).to be_valid
    end

    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_length_of(:first_name).is_at_most(25) }

    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_length_of(:last_name).is_at_most(25) }

    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_most(50) }
    it { is_expected.to_not allow_value('user@example,com').for(:email) }
    it { is_expected.to_not allow_value('user_at_foo.org').for(:email) }
    it { is_expected.to_not allow_value('user.name@example.').for(:email) }
    it { is_expected.to_not allow_value('foo@bar_baz.com').for(:email) }
    it { is_expected.to_not allow_value('foo@bar+baz.com').for(:email) }

    it { is_expected.to validate_presence_of :password }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }
    it { is_expected.to_not allow_value('12345678').for(:password) } # best practice for this?
    it { is_expected.to have_secure_password }

    describe "#password" do
      let(:user) { FactoryBot.build(:user, password: "1234567a") }

      it "is valid if password is 8 characters" do
        expect(user).to be_valid
      end

      it "must have at least 8 characters to be valid" do
        user.password = "123456a"
        expect(user).to_not be_valid
      end

      it "must have at least 1 letter to be valid" do
        user.password = "12345678"
        expect(user).to_not be_valid
      end

      it "must have at least 1 number to be valid" do
        user.password = "abcdefgh"
        expect(user).to_not be_valid
      end

      it "can only contain letters and numbers" do
        user.password = "ab-cd1_2"
        expect(user).to_not be_valid
      end
    end
  end

  context "associations" do
    it { is_expected.to have_many(:houses) }
  end

  context "instance methods" do
    let(:user) { FactoryBot.build(:user, first_name: "Sterling", last_name: "Archer") }

    describe "#name" do
      it "returns a user's full name as a string" do
        expect(user.name).to eq("Sterling Archer")
      end
    end

    describe "#authenticate" do
      it "returns the user object if the correct password is given" do
        expect(user.authenticate("pass2017")).to eq(user)
      end

      it "returns false if incorrect password is given" do
        expect(user.authenticate("not_the_right_password")).to eq(false)
      end

      it "returns true with double-bang and correct password is given" do
        expect(!!user.authenticate("pass2017")).to eq(true)
      end
    end
  end
end
