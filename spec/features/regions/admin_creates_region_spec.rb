require 'rails_helper'
RSpec.describe 'Region Feature Tests', type: :feature do

  let(:region_path) {'/regions'}

  before(:each) {
    @user = FactoryBot.create(:user, :admin)
    log_in_as(@user)
  }

  describe "Region Creation" do
    it "Allows the creation of a new region" do
      visit region_path
      expect(current_path).to eq region_path

      click_on "Add Region"
      fill_in "region_name", with: "Test Region"
      click_on "Add Region"

      expect(current_path).to eq region_path
      expect(page).to have_selector('div.alert.alert-dismissible.fade.show.alert-success', text: 'Region successfully created.')
    end

    it "Does not allow the creation of a duplicate region" do
      FactoryBot.create(:region, name: "Test Region")

      visit region_path
      expect(current_path).to eq region_path

      click_on "Add Region"
      fill_in "region_name", with: "Test Region"
      click_on "Add Region"

      expect(current_path).to eq region_path
      expect(page).to have_selector('#error_explanation', text: "1 error prohibited this region from being saved:\nName has already been taken")
    end
  end
end
