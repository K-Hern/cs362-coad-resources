require 'rails_helper'

# GET    /regions(.:format)               regions#index
# POST   /regions(.:format)               regions#create
# GET    /regions/new(.:format)           regions#new
# GET    /regions/:id/edit(.:format)      regions#edit
# GET    /regions/:id(.:format)           regions#show
# PATCH  /regions/:id(.:format)           regions#update
# PUT    /regions/:id(.:format)           regions#update
# DELETE /regions/:id(.:format)           regions#destroy

RSpec.describe RegionsController, type: :controller do
  describe "Region Controller" do

    describe "Logged Out:" do
      let(:user) { FactoryBot.create(:user) }

      describe "#GET - /regions(.:format) - regions#index" do
        it "Redirects Unauthenticated users to sign in" do
          expect(get(:index)).to redirect_to new_user_session_path
        end
      end

      describe "POST - /regions(.:format) - regions#create" do
        it "Redirects User from POST region to sign in" do
          post(:create, params: { region: FactoryBot.attributes_for(:region) })
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe "GET - /regions/new(.:format) - regions#new" do
        it "Redirects user from new to sign in" do
          expect(get(:new)).to redirect_to new_user_session_path
        end
      end

      describe "GET - /regions/:id/edit(.:format) - regions#edit" do

      end

      describe "GET - /regions/:id(.:format) - regions#show" do

      end

      describe "PATCH - /regions/:id(.:format) - regions#update" do

      end

      describe "PUT - /regions/:id(.:format) - regions#update" do

      end

      describe "DELETE - /regions/:id(.:format) - regions#destroy" do

      end


    end

    describe "Logged in as User (Non Admin):" do
      let(:user) { FactoryBot.create(:user) }
      before(:each) { sign_in user }

      describe "#GET - /regions(.:format) - regions#index" do
        it "Redirects to dashboard" do
          expect(get(:index)).to redirect_to dashboard_path
        end
      end

      describe "POST - /regions(.:format) - regions#create" do
        it "Something" do
          post(:create, params: { region: FactoryBot.attributes_for(:region) })
          expect(response).to redirect_to dashboard_path
        end
      end

      describe "GET - /regions/new(.:format) - regions#new" do
        it { expect(get(:new)).to redirect_to dashboard_path }
      end

      describe "GET - /regions/:id/edit(.:format) - regions#edit" do

      end

      describe "GET - /regions/:id(.:format) - regions#show" do

      end

      describe "PATCH - /regions/:id(.:format) - regions#update" do

      end

      describe "PUT - /regions/:id(.:format) - regions#update" do

      end

      describe "DELETE - /regions/:id(.:format) - regions#destroy" do

      end


    end

    describe "Logged in as Admin:" do
      let(:test_region) {FactoryBot.create(:region, name: "Test Region")}
      let(:user) { FactoryBot.create(:user, :admin) }
      before(:each) { sign_in user }

      describe "#GET - /regions(.:format) - regions#index" do
        it "Successfully returns the regions dashboard" do
          expect(get(:index)).to be_successful
        end
      end

      describe "POST - /regions(.:format) - regions#create" do
        it "Redirects user regions" do
          post(:create, params: { region: FactoryBot.attributes_for(:region) })
          expect(response).to redirect_to regions_path
        end

        it "Renders new when region is not created successfully" do
          post(:create, params: { region: {name: ""} })
          expect(response).to render_template(:new)
        end
      end

      describe "GET - /regions/new(.:format) - regions#new" do
        it "Renders add a region" do
          expect(get(:new)).to be_successful
        end
      end

      describe "GET - /regions/:id/edit(.:format) - regions#edit" do
        it "Renders Region edit" do
          get(:edit, params: { id: test_region.id })
          expect(response).to be_successful
        end
      end

      describe "GET - /regions/:id(.:format) - regions#show" do
        it "Renders Region Information by ID" do
          get(:show, params: { id: test_region.id })
          expect(response).to be_successful
        end
      end

      describe "PATCH - /regions/:id(.:format) - regions#update" do
        it "Updates and Displays a Region using PATCH" do
          patch(:update, params: {id: test_region.id, region: {name: "New Name"}})
          test_region.reload # Reload re-retrieves the attributes from the DB

          expect(test_region.name).to eq("New Name")
          expect(response).to redirect_to "/regions/#{test_region.id}"
        end

        it "Renders the new template when update fails - PATCH" do
          patch(:update, params: {id: test_region.id, region: {name: ""} })
          expect(response).to render_template(:edit)
        end
      end

      describe "PUT - /regions/:id(.:format) - regions#update" do
        it "Updates and Displays a Region using PUT" do
          put(:update, params: {id: test_region.id, region: {name: "New Name"}})
          test_region.reload

          expect(test_region.name).to eq("New Name")
          expect(response).to redirect_to "/regions/#{test_region.id}"
        end

        it "Renders the new template when update fails - PUT" do
          put(:update, params: {id: test_region.id, region: {name: ""} })
          expect(response).to render_template(:edit)
        end
      end

      describe "DELETE - /regions/:id(.:format) - regions#destroy" do
        it "Deletes the region and assigns its tickets to unspecified" do
          new_ticket = FactoryBot.create(:ticket, region: test_region, organization_id: nil)
          delete(:destroy, params: {id: test_region.id})
          new_ticket.reload

          expect(new_ticket.region).to eq(Region.unspecified)
          expect(response).to redirect_to regions_path
        end
      end
    end
  end
end
