require 'rails_helper'

RSpec.describe 'Creating an Organization Application', type: :feature do
    it "allows a new organization to apply for help" do
        visit root_path
        click_on "Give Help"
        click_on "Apply Now"
        
        fill_in 'Email', with: 'org@example.com'
        fill_in 'Password', with: 'password123'
        fill_in 'Password confirmation', with: 'password123'
        
        click_button "Sign up"
        expect(page).to have_text("A message with a confirmation link")
    end
end
