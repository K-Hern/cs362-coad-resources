require 'rails_helper'

RSpec.describe Region, type: :model do

  let(:region) {Region.new()}

  # To be Deleted
  it "exists" do
    Region.new
  end

  # Attribute Testing
  it "has a name" do
    expect(region).to respond_to(:name)
  end

  # Association testing
  it  "has many tickets" do
    should have_many(:tickets)
  end

  it  "has a name between 1 & 255 chars" do
    should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create)
  end

  it  "has a unique and non case sensitive name" do
    should validate_uniqueness_of(:name).case_insensitive
  end

  # Tests concerning the class definition
  it "has a string representation that is its name" do
    name = 'Mt. Hood'
    region = Region.new(name: name)
    result = region.to_s
  end
end

describe ".unspecified" do
  it "returns the 'Unspecified' region" do
    unspecified_region = Region.unspecified
    expect(unspecified_region.name).to eq('Unspecified')
  end

  it "creates the 'Unspecified' region if it does not exist" do
    expect { Region.unspecified }.to change { Region.count }.by(1)
  end

  it "does not create a new 'Unspecified' region if it already exists" do
    Region.create(name: 'Unspecified')
    expect { Region.unspecified }.not_to change { Region.count }
  end
end
