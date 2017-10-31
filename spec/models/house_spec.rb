require 'rails_helper'

describe House do
  it { should belong_to :user }

  it { should_not have_valid(:street).when(nil, "") }
  it { should have_valid(:street).when("101 Arch Street") }

  it { should_not have_valid(:city).when(nil, "") }
  it { should have_valid(:city).when("Boston") }

  it { should_not have_valid(:state).when(nil, "") }
  it { should have_valid(:state).when("MA") }

  it { should_not have_valid(:zip_code).when(nil, "", "abcde", 02110) }
  it { should have_valid(:zip_code).when("02110") }

  it { should have_valid(:name).when(nil, "", "House Near Mom") }
  it { should have_valid(:asking_amount).when(nil, "", 200_000) }
  it { should have_valid(:total_sqft).when(nil, "", 1600) }
  it { should have_valid(:photo).when(nil, "", "photo_url") }
end
