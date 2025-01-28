require 'rails_helper'

RSpec.describe User, type: :model do

    let(:user) { User.new(email: "test@example.com") }

    before do
        user.set_default_role
    end

    it "exists" do
        User.new
    end

    describe "validation tests:" do
        describe "validates presence of:" do
            it "email" do
                should validate_presence_of(:email)
            end

            it "password" do
                should validate_presence_of(:password)
            end
        end

        describe "validates length of:" do
            it "email" do
                should validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create)
            end

            it "password" do
                should validate_length_of(:password).is_at_least(7).is_at_most(255).on(:create)
            end
        end

        describe "validates uniqueness of:" do
            it "email" do
                should validate_uniqueness_of(:email).case_insensitive
            end
        end

        describe "validates format of:" do
            it "email" do
                expect(user.email).to match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
            end
        end
    end

    describe "belongs to test:" do
        it "organization" do
            should belong_to(:organization).optional
        end
    end

    describe "attribute tests:" do
        it "email" do
            expect(user).to respond_to(:email)
        end

        it "role" do
            expect(user).to respond_to(:role)
        end

        it "organization_id" do
            expect(user).to respond_to(:organization_id)
        end
    end

    it "has a default role of organization" do
        expect(user.role).to eq("organization")
    end

    it "returns the email as a string" do
        expect(user.to_s).to eq(user.email)
    end
end
