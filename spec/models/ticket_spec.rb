require 'rails_helper'

RSpec.describe Ticket, type: :model do

    let (:ticket) { Ticket.new }

    it "exists" do
        expect(Ticket.new)
    end

# TODO: belongs_to

    it "validates presence of name" do
        should validate_presence_of(:name)
    end

    it "validates presence of phone" do
        should validate_presence_of(:phone)
    end

    it "validates presence of region_id" do
        should validate_presence_of(:region_id)
    end

    it "validates presence of resource_category_id" do
        should validate_presence_of(:resource_category_id)
    end

    it "validates length of name" do
        should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create)
    end

    it "validates length of description" do
        should validate_length_of(:description).is_at_most(1020).on(:create)
    end
    
    describe "Phone number validation" do
        let(:valid_phone) { "555-123-4567" } 
        it "should be considered valid" do
            expect(valid_phone).to match(/\d{3}-\d{3}-\d{4}/) 
        end
        let(:invalid_phone) { "abc-123-4567" }
        it "should not be considered valid" do
            expect(invalid_phone).to_not match(/\d{3}-\d{3}-\d{4}/) 
        end
    end
end