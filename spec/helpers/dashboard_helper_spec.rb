require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DashboardHelper. For example:
#
# describe DashboardHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe DashboardHelper, type: :helper do
  describe "dashboard_for" do

    let(:orgObj) do
      Organization.new(
        name: "example organization",
        email: "example@example.com",
        phone: "+1 541-567-0972",
        primary_name: "Example Org",
        secondary_name: "Example Org2",
        secondary_phone: "+1 541-826-9832"
      )
    end

    let(:user) do
      User.new(
        email: "example@exmaple.com",
        password: "This is a test",
        role: :organization,
        organization: orgObj
        )
    end

    it "Returns Admin access for admin Users" do
      user.role = :admin
      expect(help.dashboard_for(user)).to eq('admin_dashboard')
    end

    it "Returns the submitted dashboard for Organizations w/ submissions" do
      expect(helper.dashboard_for(user)).to eq('organization_submitted_dashboard')
    end

    it "Returns the approved dashboard for Organizations w/ approved submissions" do
      orgObj.approve
      expect(helper.dashboard_for(user)).to eq('organization_approved_dashboard')
    end

    it "Returns the creation application for users with no organization" do
      user.organization = nil
      expect(helper.dashboard_for(user)).to eq('create_application_dashboard')
    end
  end

end
