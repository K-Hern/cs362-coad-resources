require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  it "exists" do
    ResourceCategory.new
  end

  it "has a name" do
    resourceCat = ResourceCategory.new
    expect(resourceCat).to respond_to(:name)
  end

  it "has a string representation that is its name" do
    name = 'Shelter'
    resourceCat = ResourceCategory.new(name: name)
    result = resourceCat.to_s
  end

  it "has a name with length between 1 and 255" do
    name = 'Shelter'
    resourceCat = ResourceCategory.new(name: name)
    result = resourceCat.to_s
    expect(result.length).to be_between(1, 255)
  end

  it "has a boolean status flag" do
    resourceCat = ResourceCategory.new()
    expect(resourceCat).to respond_to(:active)
  end

  it "has a way to check active status" do
    resourceCat = ResourceCategory.new
    expect(resourceCat).to respond_to(:inactive?)
  end

  it "has a way to change status" do
    resourceCat = ResourceCategory.new(name: "Tester", active: false)
    resourceCat.activate()
    expect(resourceCat.inactive?).to be_falsey()
  end



end
