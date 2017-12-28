require 'rails_helper'

describe Note do
  context "FactoryBot" do
    it "has a valid factory" do
      note = FactoryBot.build(:note)
      expect(note).to be_valid
    end

    it "uses a sequence for fields requiring uniqueness" do
      note1 = FactoryBot.create(:note)
      house = note1.house
      user = note1.user
      note2 = FactoryBot.build(:note, user: user, house: house)

      expect(note2).to be_valid
    end
  end

  context "validations" do
    it "is valid with a house, user and room" do
      house =  FactoryBot.build(:house)
      note = Note.new(
        house: house,
        user: house.user,
        room: "Living Room",
        pros: "open floor-plan layout and great for entertaining",
        cons: "no fireplace"
      )

      expect(note).to be_valid
    end

    it { is_expected.to validate_presence_of :room }
    it { is_expected.to have_db_column(:room).of_type(:string) }
    it { is_expected.to validate_uniqueness_of(:room) }
    it { is_expected.to validate_uniqueness_of(:room).scoped_to(:house_id) }
    it { is_expected.to_not validate_uniqueness_of(:room).scoped_to(:user_id) }

    it { is_expected.not_to validate_presence_of :rating }
    it { is_expected.to have_db_column(:rating).of_type(:integer) }
    it { is_expected.to validate_numericality_of(:rating).only_integer }
    it { is_expected.to validate_inclusion_of(:rating).in_range(-1..1) }
    it { is_expected.to have_db_column(:rating).
      with_options(default: 0) }

    it { is_expected.not_to validate_presence_of :pros }
    it { is_expected.to have_db_column(:pros).of_type(:text) }
    it { is_expected.to validate_length_of(:pros).is_at_most(280) }

    it { is_expected.not_to validate_presence_of :cons }
    it { is_expected.to have_db_column(:cons).of_type(:text) }
    it { is_expected.to validate_length_of(:cons).is_at_most(280) }
  end

  context "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:house) }
  end

  context "instance methods" do
    let(:note) { FactoryBot.create(:note, rating: 0) }

    describe "#rating_string" do
      it "returns a string for a note rating" do
        expect(note.rating_string).to be_a(String)
      end

      it "returns 'Like' when rating is 1" do
        note.rating = 1
        expect(note.rating_string).to eq("Like")
      end

      it "returns 'Dislike' when rating is -1" do
        note.rating = -1
        expect(note.rating_string).to eq("Dislike")
      end

      it "returns 'Neutral' when rating is 0" do
        note.rating = 0
        expect(note.rating_string).to eq("Neutral")
      end

      it "returns empty string when rating is any other value" do
        note.rating = 2
        expect(note.rating_string).to eq("")

        note.rating = -2
        expect(note.rating_string).to eq("")
      end
    end
  end
end
