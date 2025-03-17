require 'rails_helper'

RSpec.describe 'Approving an organization', type: :feature do  
    before(:each) do
        @user = FactoryBot.create(:user, :admin)
        log_in_as(@user)
        @org = create(:organization, name: "Pending Org")
    end
  
    it "allows an admin to approve a submitted organization" do
        visit '/organizations'
        click_on "All"
      
        click_on @org.name
      
        expect(current_path).to eq "/organizations/#{@org.id}"
      
        click_on "Approve"
      
        expect(page).to have_text("Organization #{@org.name} has been approved")
    end
end
