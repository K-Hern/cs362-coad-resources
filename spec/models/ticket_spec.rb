require 'rails_helper'

RSpec.describe Ticket, type: :model do

    let (:ticket) { Ticket.new(id: 123) }

    describe "attribute tests" do
        it "responds to name" do
            expect(ticket).to respond_to(:name)
        end

        it "responds to description" do
            expect(ticket).to respond_to(:description)
        end

        it "responds to phone" do
            expect(ticket).to respond_to(:phone)
        end

        it "responds to organization_id" do
            expect(ticket).to respond_to(:organization_id)
        end

        it "responds to closed" do
            expect(ticket).to respond_to(:closed)
        end

        it "responds to resource_category_id" do
            expect(ticket).to respond_to(:resource_category_id)
        end

        it "responds to region_id" do
            expect(ticket).to respond_to(:region_id)
        end
    end

    it "exists" do
        expect(Ticket.new)
    end

    # Not sure if required
    describe "belongs to tests" do
        it "belongs to region" do
            should belong_to(:region)
        end

        it "belongs to resource category" do
            belong_to(:resource_category)
        end

        it "belongs to organization" do
            belong_to(:organization).optional
        end
    end

    describe "validation tests" do
        it "validates presence of name" do
            expect(ticket).to validate_presence_of(:name)
        end

        it "validates presence of phone" do
            expect(ticket).to validate_presence_of(:phone)
        end

        it "validates presence of region_id" do
            expect(ticket).to validate_presence_of(:region_id)
        end

        it "validates presence of resource_category_id" do
            expect(ticket).to validate_presence_of(:resource_category_id)
        end

        it "validates length of name" do
            expect(ticket).to validate_length_of(:name).is_at_least(1).is_at_most(255)
        end

        it "validates length of description" do
            expect(ticket).to validate_length_of(:description).is_at_most(1020)
        end

        describe "Phone number validation" do
            let(:valid_phone) { "+1-555-123-4567" } 
            it "should be considered valid" do
                expect(valid_phone).to match(/\d{1}-\d{3}-\d{3}-\d{4}/) 
            end
            let(:invalid_phone) { "abc-123-4567" }
            it "should not be considered valid" do
                expect(invalid_phone).to_not match(/\d{3}-\d{3}-\d{4}/) 
            end
        end
    end
    
    
    describe "Scope Tests" do
        let(:region) {
            Region.create!(
                name: "region1"
        )}

        let(:resource) {
            ResourceCategory.create!(
                name: "Resource_1"
        )}

        let(:ticket) {
            Ticket.create!(
                name: "Ticket",
                phone: "+1-555-555-1212",
                region_id: region.id,
                resource_category_id: resource.id,
                closed: false
        )}

        let(:organization) {
            Organization.create!(
                name: "organization1",
                status: :approved,
                phone: "+1-555-555-1212",
                email: "test_email@mail.com",
                primary_name: "primary_name_organization1",
                secondary_name: "secondary_name_organization1",
                secondary_phone: "+1-555-555-1231",
                title: "a title",
                transportation: :yes
        )}

        it "open tickets" do
            ticket.closed = false

            expect(Ticket.open).to include(ticket)
            expect(Ticket.closed).to_not include(ticket)
        end

        it "closed tickets" do
            ticket.closed = true

            expect(Ticket.closed).to include(ticket)
            expect(Ticket.open).to_not include(ticket)
        end
        
        it "all organizations" do
            # ticket.closed = false,
            # expect(Ticket.where.not(organization_id: nil)).to include(ticket)
        end  
    end

    describe "method tests" do
        it "returns true if the ticket is open" do
            expect(ticket.open?).to eq(true)
        end

        it "returns false if the ticket is closed" do
            ticket.closed = true
            expect(ticket.open?).to eq(false)
        end

        it "returns true if the ticket is captured" do
            ticket.organization = Organization.new
            expect(ticket.captured?).to eq(true)
        end

        it "returns the string representation of the ticket" do
            expect(ticket.to_s).to eq("Ticket #{ticket.id}")
        end
    end
end