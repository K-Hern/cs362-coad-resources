require 'rails_helper'


RSpec.describe 'Region Feature Tests', type: :feature do

  let(:region_path) {'/regions'}
  let(:tickets_path) {'/tickets'}

  before(:each) {
    @user = FactoryBot.create(:user, :admin)
    log_in_as(@user)
  }

  describe "Region Dashboard" do
    it "shows the created regions as a list" do
      region1 = FactoryBot.create(:region, name: "Test Region")
      region2 = FactoryBot.create(:region, name: "Test Region 2")

      visit region_path
      expect(current_path).to eq region_path

      expect(page).to have_text(region1.name)
      expect(page).to have_text(region2.name)

    end

    it "Shows the tickets associated with the region as links" do
      region = FactoryBot.create(:region, name: "Test Region")
      ticket = FactoryBot.create(:ticket, name: "Test Ticket", region: region)

      visit region_path
      expect(current_path).to eq region_path

      click_on region.name
      expect(page).to have_text(ticket.name)
      click_on "Ticket 1"
      expect(current_path).to eq "#{tickets_path}/#{ticket.id}"

    end
  end
end
