require 'rails_helper'
RSpec.describe 'User Feature Tests', type: :feature do

  let(:users_path) {'/users'}

  before(:each) {
    @user = FactoryBot.create(:user, :admin)
    log_in_as(@user)
  }

  describe "User list" do
    it "Shows the user list at the root" do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      user3 = FactoryBot.create(:user)

      visit users_path

      # Regex because of the /i flag
      expect(page).to have_text(/#{user1.email}/i)
      expect(page).to have_text(/#{user2.email}/i)
      expect(page).to have_text(/#{user3.email}/i)
    end
  end
end
