require 'rails_helper'
RSpec.describe 'Edit a Resource Category', type: :feature do

  let(:categories_path) {'/resource_categories'}

  before(:each) {
    @user = FactoryBot.create(:user, :admin)
    log_in_as(@user)
  }

  describe "Category Edit" do
    it "Allows the updating of an existing Resource Category" do
      cat = FactoryBot.create(:resource_category, name: "Test Category")
      new_name = "New Category Name"
      visit categories_path

      click_on cat.name
      click_on "Edit Resource Category"

      fill_in "Name", with: new_name
      click_on "Save changes"

      expect(page).to have_text("Category successfully updated")
      expect(page).to have_text(new_name)
    end
  end
end
