require 'rails_helper'

# GET    /users(.:format)               users#index

RSpec.describe UsersController, type: :controller do
  describe "Users Controller" do

    describe "Logged Out:" do
      let(:user) { FactoryBot.create(:user) }

      describe "#GET - /users(.:format) - users#index" do
        it "Redirects Unauthenticated users to sign in" do
          expect(get(:index)).to redirect_to new_user_session_path
        end
      end
    end

    describe "Logged in as User (Non Admin):" do
      let(:user) { FactoryBot.create(:user) }
      before(:each) { sign_in user }

      describe "#GET - /users(.:format) - users#index" do
        it "Redirects to dashboard" do
          expect(get(:index)).to redirect_to dashboard_path
        end
      end
    end

    describe "Logged in as Admin:" do
      let(:user) { FactoryBot.create(:user, :admin) }
      before(:each) { sign_in user }

      describe "#GET - /users(.:format) - users#index" do
        it "Successfully returns the regions dashboard" do
          expect(get(:index)).to be_successful
        end
      end
    end
  end
end
