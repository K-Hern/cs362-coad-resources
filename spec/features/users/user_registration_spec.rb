require 'rails_helper'

RSpec.describe 'User registration', type: :feature do
    let(:signup_path) { '/signup' }

    describe "Registration process" do
        it "allows a new user to sign up" do
            visit signup_path
            expect(current_path).to eq '/signup'

            fill_in 'Email', with: 'test@example.com'
            fill_in 'Password', with: 'password123'
            fill_in 'Password confirmation', with: 'password123'

            click_button "Sign up"
            expect(page).to have_text("A message with a confirmation")
        end
    end
end
