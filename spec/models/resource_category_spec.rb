require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let(:resourceCat) {ResourceCategory.new(name: "Shelter", active: true)}

  describe "Class tests" do # Class & Method testing
    it "exists" do
      ResourceCategory.new
    end

    it "has a string representation that is its name" do
      result = resourceCat.to_s
      expect(result).to eq("Shelter")
    end

    it "has a way to check active status" do
      expect(resourceCat).to respond_to(:inactive?)
    end

    it "has a way to activate status" do
      resourceCat = ResourceCategory.new(name: "Tester", active: false)
      resourceCat.activate()
      expect(resourceCat.inactive?).to be_falsey()
    end

    it "has a way to deactivate status" do
      resourceCat.deactivate()
      expect(resourceCat.inactive?).to be_truthy()
    end

    describe ".unspecified" do
      it "returns the 'Unspecified' resourceCat" do
        unspecified_resourceCat = ResourceCategory.unspecified
        expect(unspecified_resourceCat.name).to eq('Unspecified')
      end

      it "creates the 'Unspecified' resourceCat if it does not exist" do
        expect { ResourceCategory.unspecified }.to change { ResourceCategory.count }.by(1)
      end

      it "does not create a new 'Unspecified' resourceCat if it already exists" do
        ResourceCategory.create(name: 'Unspecified')
        expect { ResourceCategory.unspecified }.not_to change { ResourceCategory.count }
      end
    end
  end

  describe "Schema Attribute Testing" do # Attribute Testing
    it "has a name" do
      expect(resourceCat).to respond_to(:name)
    end

    it "has a status" do
      expect(resourceCat).to respond_to(:active)
    end
  end

  describe "Association Testing" do # Association Testing
    it "has and belongs to many organizations" do
      should have_and_belong_to_many(:organizations)
    end

    it "has many tickets" do
      should have_many(:tickets)
    end
  end

  describe "Validation Testing" do # Validation testing
    it "has a name" do
      should validate_presence_of(:name)
    end

    it "has a name with between 1 - 255 chars" do
      should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create)
    end

    it "has a unique, non case sensitive name" do
      should validate_uniqueness_of(:name).case_insensitive()
    end
  end

  describe "Scope Testing" do # Scope Testing
    # NOTE - Scope interacts with the DB; instances must be saved to the DB, hence the *create!* method
    let(:activeResourceCat) {ResourceCategory.create!(name: "I'm Active", active: true)}
    let(:inactiveResourceCat) {ResourceCategory.create!(name: "I'm NOT Active", active: false)}

    it "has a active selection" do
      expect(ResourceCategory.active).to include(activeResourceCat)
      expect(ResourceCategory.active).to_not include(inactiveResourceCat)
    end

    it "has an inactive selection" do
      expect(ResourceCategory.inactive).to include(inactiveResourceCat)
      expect(ResourceCategory.inactive).to_not include(activeResourceCat)
    end
  end
end
