require 'rails_helper'

RSpec.describe 'Closing a ticket', type: :feature do
    let(:dashboard_path) { '/dashboard' }

    before(:each) do
        @user = FactoryBot.create(:user, :organization_approved)
        log_in_as(@user)
        @ticket = FactoryBot.create(:ticket, :captured, organization_id: @user.id)
    end

    describe "Ticket Closing" do
        it "allows a user to close an assigned ticket" do
            visit dashboard_path
            expect(current_path).to eq dashboard_path

            click_on "Tickets"
            click_on @ticket.name
            expect(current_path).to eq "/tickets/#{@ticket.id}"

            click_on "Close"
            expect(current_path).to eq dashboard_path
        end
    end
end
