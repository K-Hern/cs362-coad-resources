require 'rails_helper'

RSpec.describe 'Capturing a Ticket', type: :feature do
    let(:dashboard_path) { '/dashboard' }

    before(:each) {
        @user = FactoryBot.create(:user, :organization_approved)
        log_in_as(@user)
        @ticket = create(:ticket)
    }

    describe "Ticket Capture" do
        it "allows a user to capture an unassigned ticket" do
            visit dashboard_path
            expect(current_path).to eq dashboard_path
                  
            click_on "Tickets"
 
            click_on @ticket.name
            expect(current_path).to eq "/tickets/#{@ticket.id}"
            
            click_on "Capture"
            expect(current_path).to eq dashboard_path
        end
    end
end