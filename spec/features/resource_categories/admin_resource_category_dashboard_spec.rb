require 'rails_helper'
RSpec.describe 'Resource Category Dashboard', type: :feature do

  let(:categories_path) {'/resource_categories'}

  before(:each) {
    @user = FactoryBot.create(:user, :admin)
    log_in_as(@user)
  }

  describe "Resource Category Dashboard Presentation" do
    it "Shows all the Resource Categories in the dashboard" do
      cat1 = FactoryBot.create(:resource_category, name: "Test Category")
      cat2 = FactoryBot.create(:resource_category, name: "Test Category 2")

      visit categories_path

      expect(page).to have_text(cat1.name)
      expect(page).to have_text(cat2.name)
    end

    it "Renders each Resource Category as a link in the dashboard" do
      cat1 = FactoryBot.create(:resource_category, name: "Test Category")
      visit categories_path

      click_on cat1.name

      expect(current_path).to eq "#{categories_path}/#{cat1.id}"
      expect(page).to have_text(cat1.name)
    end
  end
end
