require 'rails_helper'
RSpec.describe 'Deleting a Resource Category', type: :feature do

  let(:categories_path) {'/resource_categories'}

  before(:each) {
    @user = FactoryBot.create(:user, :admin)
    log_in_as(@user)
  }

  describe "Category Deletion" do
    it "Allows the deletion of an existing Resource Category" do
      FactoryBot.create(:resource_category, name: "Test Category")
      visit categories_path

      click_on "Test Category"
      click_on "Delete"

      expect(page).to have_text("Category Test Category was deleted.")
    end
  end
end
