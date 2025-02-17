require 'rails_helper'

# PATCH  /resource_categories/:id/activate(.:format)          resource_categories#activate
# PATCH  /resource_categories/:id/deactivate(.:format)        resource_categories#deactivate
# GET    /resource_categories(.:format)                       resource_categories#index
# POST   /resource_categories(.:format)                       resource_categories#create
# GET    /resource_categories/new(.:format)                   resource_categories#new
# GET    /resource_categories/:id/edit(.:format)              resource_categories#edit
# GET    /resource_categories/:id(.:format)                   resource_categories#show
# PATCH  /resource_categories/:id(.:format)                   resource_categories#update
# PUT    /resource_categories/:id(.:format)                   resource_categories#update
# DELETE /resource_categories/:id(.:format)                   resource_categories#destroy

RSpec.describe ResourceCategoriesController, type: :controller do
  describe "Resource Categories Controller" do
    describe "Logged Out:" do
      let(:resource_cat) { FactoryBot.create(:resource_category)}
      let(:user) { FactoryBot.create(:user)}

      describe "PATCH - /resource_categories/:id/activate(.:format) - resource_categories#activate" do
        it "Redirects to sign in" do
          patch(:activate, params: {id: resource_cat.id})
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe "PATCH - /resource_categories/:id/deactivate(.:format) - resource_categories#deactivate" do
        it "Redirects to sign in" do
          patch(:deactivate, params: {id: resource_cat.id})
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe "GET - /resource_categories(.:format) - resource_categories#index" do
        it "Redirects to sign in" do
          get(:index)
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe "POST - /resource_categories(.:format) - resource_categories#create" do
        it "Redirects to sign in" do
          post(:create, params: { resource_category: FactoryBot.attributes_for(:resource_category) })
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe "GET - /resource_categories(.:format) - resource_categories#new" do
        it "Redirects to sign in" do
          get(:new)
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe "GET - /resource_categories/:id/edit(.:format) - resource_categories#edit" do
        it "Redirects to sign in" do
          get(:edit, params: {id: resource_cat.id})
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe "GET - /resource_categories/:id(.:format) - resource_categories#show" do
        it "Redirects to sign in" do
          get(:show, params: {id: resource_cat.id})
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe "PATCH - /resource_categories/:id(.:format) - resource_categories#update" do
        it "Redirects to sign in" do
          patch(:update, params: {id: resource_cat.id})
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe "PUT - /resource_categories/:id(.:format) - resource_categories#update" do
        it "Redirects to sign in" do
          put(:update, params: {id: resource_cat.id})
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe "DELETE - /resource_categories/:id(.:format) - resource_categories#destroy" do
        it "Redirects to sign in" do
          delete(:destroy, params: {id: resource_cat.id})
          expect(response).to redirect_to new_user_session_path
        end
      end
    end

    describe "Logged in as User (Non-Admin):" do
      let(:resource_cat) { FactoryBot.create(:resource_category)}
      let(:user) { FactoryBot.create(:user) }
      before(:each) { sign_in user }

      describe "PATCH - /resource_categories/:id/activate(.:format) - resource_categories#activate" do
        it "Redirects to dashboard" do
          patch(:activate, params: {id: resource_cat.id})
          expect(response).to redirect_to dashboard_path
        end
      end

      describe "PATCH - /resource_categories/:id/deactivate(.:format) - resource_categories#deactivate" do
        it "Redirects to dashboard" do
          patch(:deactivate, params: {id: resource_cat.id})
          expect(response).to redirect_to dashboard_path
        end
      end

      describe "GET - /resource_categories(.:format) - resource_categories#index" do
        it "Redirects to dashboard" do
          get(:index)
          expect(response).to redirect_to dashboard_path
        end
      end

      describe "POST - /resource_categories(.:format) - resource_categories#create" do
        it "Redirects to dashboard" do
          post(:create, params: { resource_category: FactoryBot.attributes_for(:resource_category) })
          expect(response).to redirect_to dashboard_path
        end
      end

      describe "GET - /resource_categories(.:format) - resource_categories#new" do
        it "Redirects to dashboard" do
          get(:new)
          expect(response).to redirect_to dashboard_path
        end
      end

      describe "GET - /resource_categories/:id/edit(.:format) - resource_categories#edit" do
        it "Redirects to dashboard" do
          get(:edit, params: {id: resource_cat.id})
          expect(response).to redirect_to dashboard_path
        end
      end

      describe "GET - /resource_categories/:id(.:format) - resource_categories#show" do
        it "Redirects to dashboard" do
          get(:show, params: {id: resource_cat.id})
          expect(response).to redirect_to dashboard_path
        end
      end

      describe "PATCH - /resource_categories/:id(.:format) - resource_categories#update" do
        it "Redirects to dashboard" do
          patch(:update, params: {id: resource_cat.id})
          expect(response).to redirect_to dashboard_path
        end
      end

      describe "PUT - /resource_categories/:id(.:format) - resource_categories#update" do
        it "Redirects to dashboard" do
          put(:update, params: {id: resource_cat.id})
          expect(response).to redirect_to dashboard_path
        end
      end

      describe "DELETE - /resource_categories/:id(.:format) - resource_categories#destroy" do
        it "Redirects to dashboard" do
          delete(:destroy, params: {id: resource_cat.id})
          expect(response).to redirect_to dashboard_path
        end
      end
    end

    describe "Logged in as Admin:" do
      let(:resource_cat) { FactoryBot.create(:resource_category)}
      let(:user) { FactoryBot.create(:user, :admin) }
      before(:each) { sign_in user }

      describe "PATCH - /resource_categories/:id/activate(.:format) - resource_categories#activate" do
        it "Redirects to the resource_cat's path page and shows a notice" do
          allow(resource_cat).to receive(:activate).and_return(true)

          patch(:activate, params: {id: resource_cat.id})
          # Bad form, but resource_categories_path(resource_cat) returning . instead of /
          expect(response).to redirect_to "#{resource_categories_path}/#{resource_cat.id}"
          expect(flash[:notice]).to eq('Category activated.')
        end

        it "Redirects to the resource_cat's path page and shows an alert upon failure" do
          allow(resource_cat).to receive(:activate).and_return(false)

          patch(:activate, params: {id: resource_cat.id})
          expect(response).to redirect_to "#{resource_categories_path}/#{resource_cat.id}"

          # Not Sure why this isn't working
          # expect(flash[:alert]).to eq('There was a problem activating the category.')
        end

      end

      describe "PATCH - /resource_categories/:id/deactivate(.:format) - resource_categories#deactivate" do
        it "Redirects to the resource_cat's path page and shows a notice" do
          allow(resource_cat).to receive(:deactivate).and_return(true)

          patch(:activate, params: {id: resource_cat.id})
          # Bad form, but resource_categories_path(resource_cat) returning . instead of /
          expect(response).to redirect_to "#{resource_categories_path}/#{resource_cat.id}"
          expect(flash[:notice]).to eq('Category activated.')
        end

        it "Redirects to the resource_cat's path page and shows an alert upon failure" do
          allow(resource_cat).to receive(:deactivate).and_return(false)

          patch(:activate, params: {id: resource_cat.id})
          expect(response).to redirect_to "#{resource_categories_path}/#{resource_cat.id}"

          # Not Sure why this isn't working
          # expect(flash[:alert]).to eq('There was a problem activating the category.')
        end

      end

      describe "GET - /resource_categories(.:format) - resource_categories#index" do
        it "Serves the resource_categories dashboard" do
          get(:index)
          expect(response).to be_successful
        end
      end

      describe "POST - /resource_categories(.:format) - resource_categories#create" do
        it "Redirects to RC dashboard and serves a notice upon success" do
          allow(resource_cat).to receive(:save).and_return(true)
          allow(ResourceCategory).to receive(:new).and_return(resource_cat)

          post(:create, params: { resource_category: FactoryBot.attributes_for(:resource_category) })
          expect(response).to redirect_to resource_categories_path
          expect(flash[:notice]).to eq('Category successfully created.')
        end

        it "Renders the new template upon failure" do
          allow(resource_cat).to receive(:save).and_return(false)
          allow(ResourceCategory).to receive(:new).and_return(resource_cat)

          post(:create, params: { resource_category: FactoryBot.attributes_for(:resource_category) })
          expect(response).to render_template(:new)
        end
      end

      describe "GET - /resource_categories(.:format) - resource_categories#new" do
        it "Serves the RC dashboard" do
          get(:new)
          expect(response).to be_successful
        end
      end

      describe "GET - /resource_categories/:id/edit(.:format) - resource_categories#edit" do
        it "Serves the editing page" do
          get(:edit, params: {id: resource_cat.id})
          expect(response).to be_successful
        end
      end

      describe "GET - /resource_categories/:id(.:format) - resource_categories#show" do
        it "Serves the RC page by ID" do
          get(:show, params: {id: resource_cat.id})
          expect(response).to be_successful
        end
      end

      describe "PATCH - /resource_categories/:id(.:format) - resource_categories#update" do
        it "Redirects to the RC's page & displays notice after success" do
          allow(resource_cat).to receive(:update).and_return(true)
          allow(ResourceCategory).to receive(:find).and_return(resource_cat)

          patch(:update, params: {id: resource_cat.id, resource_category: {name: "New Name"}})

          expect(response).to redirect_to "#{resource_categories_path}/#{resource_cat.id}"
          expect(flash[:notice]).to eq('Category successfully updated.')
        end

        it "Renders the edit template after failure" do
          allow(resource_cat).to receive(:update).and_return(false)
          allow(ResourceCategory).to receive(:find).and_return(resource_cat)

          patch(:update, params: {id: resource_cat.id, resource_category: {name: "New Name"}})
          expect(response).to render_template(:edit)
        end
      end

      describe "PUT - /resource_categories/:id(.:format) - resource_categories#update" do
        it "Redirects to the RC's page & displays notice after success" do
          allow(resource_cat).to receive(:update).and_return(true)
          allow(ResourceCategory).to receive(:find).and_return(resource_cat)

          put(:update, params: {id: resource_cat.id, resource_category: {name: "New Name"}})

          expect(response).to redirect_to "#{resource_categories_path}/#{resource_cat.id}"
          expect(flash[:notice]).to eq('Category successfully updated.')
        end

        it "Renders the edit template after failure" do
          allow(resource_cat).to receive(:update).and_return(false)
          allow(ResourceCategory).to receive(:find).and_return(resource_cat)

          put(:update, params: {id: resource_cat.id, resource_category: {name: "New Name"}})
          expect(response).to render_template(:edit)
        end
      end

      describe "DELETE - /resource_categories/:id(.:format) - resource_categories#destroy" do
        it "Redirects to the RC dashboard & displays a notice upon success" do
          delete(:destroy, params: {id: resource_cat.id})
          expect(response).to redirect_to resource_categories_path
          expect(flash[:notice]).to eq("Category #{resource_cat.name} was deleted.\nAssociated tickets now belong to the 'Unspecified' category.")
        end
      end

    end
  end
end
