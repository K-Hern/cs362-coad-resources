require 'rails_helper'

# POST   /organizations/:id/approve(.:format)     organizations#approve
# POST   /organizations/:id/reject(.:format)      organizations#reject
# GET    /organizations/:id/resources(.:format)   organizations#resources
# GET    /organizations(.:format)                 organizations#index
# POST   /organizations(.:format)                 organizations#create
# GET    /organizations/new(.:format)             organizations#new
# GET    /organizations/:id/edit(.:format)        organizations#edit
# GET    /organizations/:id(.:format)             organizations#show
# PATCH  /organizations/:id(.:format)             organizations#update
# PUT    /organizations/:id(.:format)             organizations#update
# DELETE /organizations/:id(.:format)             organizations#destroy

RSpec.describe OrganizationsController, type: :controller do
  describe "Organizations Controller" do
    describe "Logged Out:" do
      let(:org) { FactoryBot.build_stubbed(:organization)}
      let(:user) { FactoryBot.create(:user) }

      describe "POST - /organizations/:id/approve(.:format) - organizations#approve" do
        it "Redirects to sign in" do
          post(:approve, params: {id: org.id})
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe "POST - /organizations/:id/reject(.:format) - organizations#reject" do
        it "Redirects to sign in" do
          post(:reject, params: {id: org.id})
          expect(response).to redirect_to new_user_session_path
        end
      end


      #resources is not a method in the organizations controller - why is this in the routes?

      #describe "GET - /organizations/:id/resources(.:format) - organizations#resources" do
      #  it "Redirects to sign in" do
      #    get(:resources, params: {id: org.id})
      #    expect(response).to redirect_to new_user_session_path
      #  end
      #end

      describe "GET - /organizations(.:format) - organizations#index" do
        it "Redirects to sign in" do
          get(:index)
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe "POST - /organizations(.:format) - organizations#create" do
        it "Redirects to sign in" do
          post(:create)
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe "GET - /organizations/new(.:format) - organizations#new" do
        it "Redirects to sign in" do
          get(:new)
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe "GET - /organizations/:id/edit(.:format) - organizations#edit" do
        it "Redirects to sign in" do
          get(:edit, params: {id: org.id})
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe "GET - /organizations/:id(.:format) - organizations#show" do
        it "Redirects to sign in" do
          get(:show, params: {id: org.id})
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe "PATCH - /organizations/:id(.:format) - organizations#update" do
        it "Redirects to sign in" do
          patch(:update, params: {id: org.id})
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe "PUT - /organizations/:id(.:format) - organizations#update" do
        it "Redirects to sign in" do
          put(:update, params: {id: org.id})
          expect(response).to redirect_to new_user_session_path
        end
      end


      #destroy is not a method in the organizations controller - why is this in the routes?

      #describe "DELETE - /organizations/:id(.:format) - organizations#destroy" do
      #  it "Redirects to sign in" do
      #    delete(:destroy, params: {id: org.id})
      #    expect(response).to redirect_to new_user_session_path
      #  end
      #end

    end

    describe "Logged in as User (Non-Admin):" do
      let(:user) { FactoryBot.create(:user) }
      before(:each) { sign_in user }

      
    end
  end
end
