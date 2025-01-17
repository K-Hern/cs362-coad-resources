require 'rails_helper'

RSpec.describe Organization, type: :model do

    describe "organizations" do
        let (:org) { Organization.new }

        it "exists" do
            Organization.new
        end

        it "responds to name" do
            expect(org).to respond_to(:name)
        end

        it "responds to status" do
            expect(org).to respond_to(:status)
        end

        it "responds to phone" do
            expect(org).to respond_to(:phone)
        end
        
        it "responds to email" do
            expect(org).to respond_to(:email)
        end

        it "responds to description" do
            expect(org).to respond_to(:description)
        end

        it "responds to rejection_reason" do
            expect(org).to respond_to(:rejection_reason)
        end

        it "responds to liability_insurance" do
            expect(org).to respond_to(:liability_insurance)
        end

        it "responds to primary_name" do
            expect(org).to respond_to(:primary_name)
        end

        it "responds to secondary_name" do
            expect(org).to respond_to(:secondary_name)
        end

        it "responds to secondary_phone" do
            expect(org).to respond_to(:secondary_phone)
        end

        it "responds to title" do
            expect(org).to respond_to(:title)
        end

        it "responds to transportation" do
            expect(org).to respond_to(:transportation)
        end
    end
end
