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

    end

    describe "Logged in as User (Non-Admin):" do
      let(:org) { FactoryBot.build_stubbed(:organization)}
      let(:user) { FactoryBot.create(:user) }
      before(:each) { sign_in user }

      describe "POST - /organizations/:id/approve(.:format) - organizations#approve" do
        it "" do
        end
      end

      describe "POST - /organizations/:id/reject(.:format) - organizations#reject" do
        it "" do
        end
      end

      describe "GET - /organizations(.:format) - organizations#index" do
        it "Serves dashboard" do
          get(:index)
          expect(response).to be_successful
        end
      end

      describe "POST - /organizations(.:format) - organizations#create" do
        it "" do
        end
      end

      describe "GET - /organizations/new(.:format) - organizations#new" do
        it "redirects to dashboard" do
          get(:new, params: { id: org.id })
          expect(response).to be_successful
        end
      end

      describe "GET - /organizations/:id/edit(.:format) - organizations#edit" do
        it "" do
        end
      end

      describe "GET - /organizations/:id(.:format) - organizations#show" do
        it "" do
        end
      end

      describe "PATCH - /organizations/:id(.:format) - organizations#update" do
        it "" do
        end
      end

      describe "PUT - /organizations/:id(.:format) - organizations#update" do
        it "" do
        end
      end

    end

    describe "Logged in as Admin:" do
      let(:org) { FactoryBot.create(:organization)}
      let(:user) { FactoryBot.create(:user, :admin) }
      before(:each) { sign_in user }

      describe "POST - /organizations/:id/approve(.:format) - organizations#approve" do
        it "" do
        end
      end

      describe "POST - /organizations/:id/reject(.:format) - organizations#reject" do
        it "" do
        end
      end

      describe "GET - /organizations(.:format) - organizations#index" do
        it "" do

        end
      end

      describe "POST - /organizations(.:format) - organizations#create" do
        it "" do
        end
      end

      describe "GET - /organizations/new(.:format) - organizations#new" do
        it "" do
        end
      end

      describe "GET - /organizations/:id/edit(.:format) - organizations#edit" do
        it "" do
        end
      end

      describe "GET - /organizations/:id(.:format) - organizations#show" do
        it "" do
        end
      end

      describe "PATCH - /organizations/:id(.:format) - organizations#update" do
        it "" do
        end
      end

      describe "PUT - /organizations/:id(.:format) - organizations#update" do
        it "" do
        end
      end

    end
  end
end
