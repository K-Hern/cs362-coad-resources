require 'rails_helper'
RSpec.describe 'Edit a Resource Category', type: :feature do

  let(:categories_path) {'/resource_categories'}

  before(:each) {
    @user = FactoryBot.create(:user, :admin)
    log_in_as(@user)
  }

  describe "Category Edit" do
    it "Allows the updating of an existing Resource Category" do
      FactoryBot.create(:resource_category, name: "Test Category")
      visit categories_path

      click_on "Test Category"
      click_on "Edit Resource Category"

      fill_in "Name", with: "New Category Name"
      click_on "Save changes"

      expect(page).to have_text("Category successfully updated")
      expect(page).to have_text("New Category Name")
    end
  end
end
