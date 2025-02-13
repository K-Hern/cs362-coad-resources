require 'rails_helper'

RSpec.describe Ticket, type: :model do

    describe "Attribute Tests:" do
        let (:ticket) { FactoryBot.build_stubbed(:ticket) }

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

    describe "Class Tests:" do
        let (:ticket) { FactoryBot.build_stubbed(:ticket) }

        it "exists" do
            Ticket.new
        end

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

    describe "Validation Tests:" do
        let (:ticket) { FactoryBot.build(:ticket, name: "Ticket") }

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
        let (:ticket_open) { FactoryBot.create(:ticket, closed: false, organization_id: nil) }
        it "open tickets" do
            expect(Ticket.open).to include(ticket_open)
            expect(Ticket.closed).to_not include(ticket_open)
        end

        let (:ticket_closed) { FactoryBot.create(:ticket, closed: true, organization_id: nil) }
        it "closed tickets" do
            expect(Ticket.open).to_not include(ticket_closed)
            expect(Ticket.closed).to include(ticket_closed)
        end
        
        let (:ticket_all_organizations) { FactoryBot.create(:ticket, closed: false, organization_id: 1) }
        it "all organizations" do
            expect(Ticket.all_organization).to include(ticket_all_organizations)
        end  

        let (:ticket_organization) { FactoryBot.create(:ticket, closed: false, organization_id: 1) }
        it "organization" do
            expect(Ticket.organization(1)).to include(ticket_organization)
        end

        let (:ticket_closed_organization) { FactoryBot.create(:ticket, closed: true, organization_id: 1) }
        it "closed_organization" do
            expect(Ticket.closed_organization(1)).to include(ticket_closed_organization)
        end

        let (:region) { FactoryBot.create(:region) }
        let (:ticket_region) { FactoryBot.create(:ticket, region: region) }
        it "region" do
            expect(Ticket.region(1)).to include(ticket_region)
        end

        let (:resource_category) { FactoryBot.create(:resource_category) }
        let (:ticket_resource_category_id) { FactoryBot.create(:ticket, resource_category: resource_category) }
        it "resource_category_id" do
            expect(Ticket.resource_category(1)).to include(ticket_resource_category_id)
        end
    end
end