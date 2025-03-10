require 'rails_helper'

RSpec.describe 'Deleting a Region', type: :feature do
  let(:region_path) {'/regions'}

  before(:each) {
    @user = FactoryBot.create(:user, :admin)
    log_in_as(@user)
  }

  describe "Region Deletion" do
    it "Allows the deletion of an existing region" do
      region = FactoryBot.create(:region, name: "Deletion Region")

      visit region_path
      expect(current_path).to eq region_path

      click_on region.name
      click_on "Delete"

      expect(current_path).to eq region_path
      expect(page).to have_text("Region #{region.name} was deleted")
    end
  end
end
