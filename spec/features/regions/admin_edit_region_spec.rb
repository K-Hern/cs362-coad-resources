require 'rails_helper'
RSpec.describe 'Region Feature Tests', type: :feature do

  let(:region_path) {'/regions'}

  before(:each) {
    @user = FactoryBot.create(:user, :admin)
    log_in_as(@user)
  }

  describe "Region Edit" do
    it "Allows the region to be updated" do
      FactoryBot.create(:region, name: "Test Region")

      visit region_path
      expect(current_path).to eq region_path

      click_on "Test Region"
      click_on "Edit Region"
      fill_in "Name", with: "New Test Region"
      click_on "Save Changes"

      expect(page).to have_text("Region successfully updated")
      expect(page).to have_text("New Test Region")
    end
  end
end
