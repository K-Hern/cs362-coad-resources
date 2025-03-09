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
      FactoryBot.create(:region, name: "Test Region")
      FactoryBot.create(:region, name: "Test Region 2")

      visit region_path
      expect(current_path).to eq region_path

      expect(page).to have_text("Test Region")
      expect(page).to have_text("Test Region 2")

    end

    it "Shows the tickets associated with the region as links" do
      @region = FactoryBot.create(:region, name: "Test Region")
      ticket = FactoryBot.create(:ticket, name: "Test Ticket", region: @region)

      visit region_path
      expect(current_path).to eq region_path

      click_on "Test Region"
      expect(page).to have_text("Test Ticket")
      click_on "Ticket 1"
      expect(current_path).to eq "#{tickets_path}/#{ticket.id}"

    end
  end
end
