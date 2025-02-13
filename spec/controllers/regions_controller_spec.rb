require 'rails_helper'

# GET    /regions(.:format)               regions#index -
# POST   /regions(.:format)               regions#create -
# GET    /regions/new(.:format)           regions#new -
# GET    /regions/:id/edit(.:format)      regions#edit -
# GET    /regions/:id(.:format)           regions#show -
# PATCH  /regions/:id(.:format)           regions#update -
# PUT    /regions/:id(.:format)           regions#update -
# DELETE /regions/:id(.:format)           regions#destroy -

RSpec.describe RegionsController, type: :controller do
  describe "Region Controller" do

    describe "Logged Out:" do
      let(:user) { FactoryBot.create(:user) }

      describe "#GET - /regions(.:format) - regions#index" do
        # Test Some Stuff
      end

      describe "POST - /regions(.:format) - regions#create" do
        # Test Some Stuff
      end

      describe "GET - /regions/new(.:format) - regions#new" do

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

    describe "Logged in as User:" do
      let(:user) { FactoryBot.create(:user) }
      before(:each) { sign_in user }

      describe "#GET - /regions(.:format) - regions#index" do
        # Test Some Stuff
      end

      describe "POST - /regions(.:format) - regions#create" do
        # Test Some Stuff
      end

      describe "GET - /regions/new(.:format) - regions#new" do

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
      let(:user) { FactoryBot.create(:user, :admin) }
      before(:each) { sign_in user }

      describe "#GET - /regions(.:format) - regions#index" do
        # Test Some Stuff
      end

      describe "POST - /regions(.:format) - regions#create" do
        # Test Some Stuff
      end

      describe "GET - /regions/new(.:format) - regions#new" do

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
  end
end
