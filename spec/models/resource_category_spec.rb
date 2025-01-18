require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let(:resourceCat) {ResourceCategory.new(name: "Shelter")}

  # To be deleted
  it "exists" do
    ResourceCategory.new
  end

  #Attribute Testing
  it "has a name" do
    expect(resourceCat).to respond_to(:name)
  end

  it "has a status" do
    expect(resourceCat).to respond_to(:active)
  end

  # Association Testing
  it "has and belongs to many organizations" do
    should have_and_belong_to_many(:organizations)
  end

  it "has many tickets" do
    should have_many(:tickets)
  end

  it "has a name" do
    should validate_presence_of(:name)
  end

  it "has a name with between 1 - 255 chars" do
    should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create)
  end

  it "has a unique, non case sensitive name" do
    should validate_uniqueness_of(:name).case_insensitive()
  end

  # These are tests concerning the attributes of the class definition (To Be deleted)
  it "has a string representation that is its name" do
    result = resourceCat.to_s
    expect(result).to eq("Shelter")
  end

  it "has a name with length between 1 and 255" do
    result = resourceCat.to_s
    expect(result.length).to be_between(1, 255)
  end

  it "has a boolean status flag" do
    expect(resourceCat).to respond_to(:active)
  end

  it "has a way to check active status" do
    expect(resourceCat).to respond_to(:inactive?)
  end

  it "has a way to change status" do
    resourceCat = ResourceCategory.new(name: "Tester", active: false)
    resourceCat.activate()
    expect(resourceCat.inactive?).to be_falsey()
  end
end
