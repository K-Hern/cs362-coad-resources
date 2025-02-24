require 'rails_helper'

RSpec.describe Organization, type: :model do

    describe "organizations:" do
        let (:org) { FactoryBot.build_stubbed(:organization) }

        it "exists" do
            FactoryBot.create(:organization)
        end

        describe "validation tests:" do
            describe "validates presence of:" do
                it "email" do
                    expect(org).to validate_presence_of(:email)
                end

                it "name" do
                    expect(org).to validate_presence_of(:name)
                end

                it "phone" do
                    expect(org).to validate_presence_of(:phone)
                end

                it "status" do
                    expect(org).to validate_presence_of(:status)
                end

                it "primary_name" do
                    expect(org).to validate_presence_of(:primary_name)
                end

                it "secondary_name" do
                    expect(org).to validate_presence_of(:secondary_name)
                end

                it "secondary_phone" do
                    expect(org).to validate_presence_of(:secondary_phone)
                end
            end

            describe "validates length of:" do
                it "email" do
                    expect(org).to validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create)
                end

                it "name" do
                    expect(org).to validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create)
                end

                it "description" do
                    expect(org).to validate_length_of(:description).is_at_most(1020).on(:create)
                end
            end

            describe "validates uniqueness of:" do
                let (:org) { FactoryBot.create(:organization) }
                it "email" do
                    expect(org).to validate_uniqueness_of(:email).case_insensitive
                end

                it "name" do
                    expect(org).to validate_uniqueness_of(:name).case_insensitive
                end
            end

            describe "validates format of:" do
                it "email" do
                    expect(org.email).to match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
                end
            end
        end

        describe "belongs to tests" do
            it "has many users" do
                should have_many(:users)
            end

            it "has many tickets" do
                should have_many(:tickets)
            end

            it "has and belongs to many resource categories" do
                should have_and_belong_to_many(:resource_categories)
            end
        end

        describe "attribute tests" do
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

        describe "status" do
            let (:org_approved) { FactoryBot.build_stubbed(:organization, :status_rejected) }
            let (:org_rejected) { FactoryBot.build_stubbed(:organization, :status_approved) }
            let (:org_submitted) { FactoryBot.build_stubbed(:organization, :status_submitted) }

            it "can be approved" do
                org_approved.approve
                expect(org_approved.status.to_sym).to eq(:approved)
            end

            it "can be rejected" do
                org_rejected.reject
                expect(org_approved.status.to_sym).to eq(:rejected)
            end

            it "sets default status to submitted" do
                org_submitted.set_default_status
                expect(org_submitted.status.to_sym).to eq(:submitted)
            end
        end

        it "returns the name as a string" do
            expect(org.to_s).to eq(org.name)

            organization = FactoryBot.build_stubbed(:organization, name: "fake_name")
            result = organization.to_s
            expect(result).to eq "fake_name"
        end
    end
end
