require 'rails_helper'

RSpec.describe 'Logging in', type: :feature do
    let(:user) { FactoryBot.create(:user, email: 'user@example.com', password: 'password123') }
  
    it "allows a user to sign in" do
        visit '/login'
        expect(current_path).to eq('/login')
      
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Sign in'
      
        expect(page).to have_text("Signed in successfully.")
    end
end
