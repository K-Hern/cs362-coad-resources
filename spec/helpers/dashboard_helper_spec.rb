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

    before(:all) do
      @orgObj =
        Organization.new(
          name: "example organization",
          email: "example@example.com",
          phone: "+1 541-567-0972",
          primary_name: "Example Org",
          secondary_name: "Example Org2",
          secondary_phone: "+1 541-826-9832"
        )

      @user = User.new(
        email: "example@exmaple.com",
        password: "This is a test",
        role: :organization,
        organization: @orgObj
        )
    end

    it "Tailors to admin Users" do
      @user.role = :admin
      expect(dashboard_for(@user)).to eq('admin_dashboard')
    end

    it "Tailors to Organizations w/ submissions" do
      @user.role = :organization # Needed due to short circuiting
      expect(dashboard_for(@user)).to eq('organization_submitted_dashboard')
    end

    it "Tailors to Organizations w/ approved submissions" do
      @user.role = :organization # Needed due to short circuiting
      @orgObj.approve
      expect(dashboard_for(@user)).to eq('organization_approved_dashboard')
    end

    it "Defaults to create a new application" do
      @user.role = :organization # Needed due to short circuiting
      @user.organization = nil
      expect(dashboard_for(@user)).to eq('create_application_dashboard')
    end
  end

end
