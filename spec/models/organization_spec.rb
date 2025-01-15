require 'rails_helper'

RSpec.describe Organization, type: :model do

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
end
