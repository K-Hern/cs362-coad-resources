require 'rails_helper'

RSpec.describe 'Updating an Organization', type: :feature do
    let(:dashboard_path) { '/dashboard' }

    before(:each) do
        @user = FactoryBot.create(:user, :organization_approved)
        log_in_as(@user)
    end

    it "allows an approved user to update organization info" do
        visit dashboard_path
        click_on "Edit Organization"
        
        fill_in "Name", with: "New Org Name"
        fill_in "Phone", with: "222-2222"
        fill_in "Email", with: "new@example.com"
        fill_in "Description", with: "New description"
        
        click_button "Update Resource"
        
        expect(current_path).to eq "/organizations/#{@user.organization_id}"
    end
end
