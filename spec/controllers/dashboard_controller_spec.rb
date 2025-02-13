require 'rails_helper'

# GET    /dashboard(.:format)         dashboard#index

RSpec.describe DashboardController, type: :controller do
    describe "Dashboard Controller" do
        describe "Logged Out:" do
            let(:user) { FactoryBot.create(:user) }

            describe "GET - /dashboard(.:format) - dashboard#index" do
                it {
                    expect(get(:index)).to redirect_to new_user_session_path
                }
            end
        end

        describe "Logged in as User:" do
            let(:user) { FactoryBot.create(:user) }
            before(:each) { sign_in user }

            describe "GET - /dashboard(.:format) - dashboard#index" do
                it {
                    expect(get(:index)).to be_successful
                }
            end
        end

        describe "Logged in as Admin:" do
            let(:user) { FactoryBot.create(:user, :admin) }
            before(:each) { sign_in user }

            describe "GET - /dashboard(.:format) - dashboard#index" do
                it {
                    expect(get(:index)).to be_successful
                }
            end
        end
    end
end
