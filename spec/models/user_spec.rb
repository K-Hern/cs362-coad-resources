require 'rails_helper'

RSpec.describe User, type: :model do

    let(:user) { User.new(email: "test@example.com") }

    before do
        user.set_default_role
    end

    it "exists" do
        User.new
    end

    it "belongs to organization" do
        belong_to(:organization).optional
    end

    it "validates presence of email" do
        should validate_presence_of(:email)
    end

    it "validates length of email" do
        should validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create)
    end

    it "validates format of email" do
  
        expect(user.email).to match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
    end

    it "validates uniqueness of email" do
        should validate_uniqueness_of(:email).case_insensitive
    end

    it "validates presence of password" do
        should validate_presence_of(:password)
    end

    it "validates length of password" do
        should validate_length_of(:password).is_at_least(7).is_at_most(255).on(:create)
    end

    it "has a default role of organization" do
        expect(user.role).to eq("organization")
    end
end
