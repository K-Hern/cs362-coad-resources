require 'rails_helper'
RSpec.describe 'Creating a Resource Category', type: :feature do

  let(:categories_path) {'/resource_categories'}

  before(:each) {
    @user = FactoryBot.create(:user, :admin)
    log_in_as(@user)
  }

  describe "Category Creation" do
    it "Allows the creation of a new Resource Category" do
      cat_name = "New Test Category"
      visit categories_path

      click_on "Add Resource Category"
      fill_in "Name", with: cat_name
      click_on "Add resource category"

      expect(page).to have_text("Category successfully created.")
      expect(page).to have_text(cat_name)
    end
  end
end
