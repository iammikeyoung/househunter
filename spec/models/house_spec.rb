require 'rails_helper'

describe House do
  context "FactoryBot" do
    it "has a valid factory" do
      house = FactoryBot.build(:house)
      expect(house).to be_valid
    end
  end

  context "validations" do
    it "is valid with a user, street, city, state and zip code" do
      user = FactoryBot.build(:user)
      house = House.new(
        user: user,
        name: "Near Work",
        street: "101 Arch Street",
        city: "Boston",
        state: "MA",
        zip_code: "02110"
      )

      expect(house).to be_valid
    end

    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_length_of(:name).is_at_most(25) }
    it "{ is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }"
    it "allows two users to share a house name" do
      user = FactoryBot.create(:user)
      FactoryBot.create(:house, user: user, name: "Test House")

      other_user = FactoryBot.create(:user)
      other_house = FactoryBot.build(:house, user: other_user, name: "Test House")

      expect(other_house).to be_valid
    end

    it { is_expected.to validate_presence_of :street }

    it { is_expected.to validate_presence_of :city }

    it { is_expected.to validate_presence_of :state }
    it { is_expected.to validate_length_of(:state).is_equal_to(2) }
    it { is_expected.to_not allow_value('12').for(:state) }
    it { is_expected.to_not allow_value('M2').for(:state) }
    it { is_expected.to_not allow_value('@m').for(:state) }

    it { is_expected.to validate_presence_of :zip_code }
    it { is_expected.to validate_length_of(:zip_code).is_equal_to(5) }
    it { is_expected.to_not allow_value('0#23m').for(:zip_code) }
    it { is_expected.to_not allow_value('$12L4').for(:zip_code) }

    it { is_expected.to_not validate_presence_of :asking_amount }
    it { is_expected.to validate_numericality_of(:asking_amount).only_integer }
    it { is_expected.to_not allow_value("200,000").for(:asking_amount) }

    it { is_expected.to_not validate_presence_of :total_sqft }
    it { is_expected.to validate_numericality_of(:total_sqft).only_integer }

    it { is_expected.to_not validate_presence_of :house_profile_pic }
    it { is_expected.to allow_value("photo_url").for(:house_profile_pic) }
  end

  context "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:notes) }
  end

  context "instance methods" do
    xdescribe "address"
    xdescribe "price_per_sqft"
  end
end
