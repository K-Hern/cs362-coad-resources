require 'rails_helper'

RSpec.describe 'Deleting a Ticket', type: :feature do
    let(:dashboard_path) { '/dashboard' }
    let(:ticket) { FactoryBot.create(:ticket) }
    before(:each) {
        @user = FactoryBot.create(:user, :admin)
        log_in_as(@user)
    }

    describe "Ticket Deletion" do
        it "allows the deletion of an existing ticket" do
            ticket = FactoryBot.create(:ticket, name: "Deletion Ticket")
            visit dashboard_path
            expect(current_path).to eq dashboard_path

            click_on ticket.name
            click_on "Delete"

            expect(current_path).to eq dashboard_path
            expect(page).to have_text("Ticket #{ticket.id} was deleted.")
        end
    end
end
