require 'rails_helper'
RSpec.describe 'Edit a Resource Category Status', type: :feature do

  let(:categories_path) {'/resource_categories'}

  before(:each) {
    @user = FactoryBot.create(:user, :admin)
    log_in_as(@user)
  }

  describe "Category Status Edit" do
    it "Allows the activation of an existing Resource Category" do
      cat = FactoryBot.create(:resource_category, name: "Test Category", active: false)
      visit categories_path

      click_on cat.name
      click_on "Activate"

      expect(page).to have_text("Category activated.")
    end

    it "Allows the activation of an existing Resource Category" do
      cat = FactoryBot.create(:resource_category, name: "Test Category", active: true)
      visit categories_path

      click_on cat.name
      click_on "Deactivate"

      expect(page).to have_text("Category deactivated.")
    end
  end
end
