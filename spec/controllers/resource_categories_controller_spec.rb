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
            let(:user) { FactoryBot.create(:user) }

            describe "PATCH - /resource_categories/:id/activate(.:format) - resource_categories#activate" do
                it {

                }
            end

            describe "PATCH - /resource_categories/:id/deactivate(.:format) - resource_categories#deactivate" do
                it {

                }
            end

            describe "GET - /resource_categories(.:format) - resource_categories#index" do
                it {
                    expect(get(:index)).to redirect_to new_user_session_path
                }
            end

            describe "POST - /resource_categories(.:format) - resource_categories#create" do
                it {
                    post(:create, params: { resource_category: FactoryBot.attributes_for(:resource_category) })
                    expect(response).to redirect_to new_user_session_path
                }
            end

            describe "GET - /resource_categories(.:format) - resource_categories#new" do
                it {
                    expect(get(:new)).to redirect_to new_user_session_path
                }
            end

            describe "GET - /resource_categories/:id/edit(.:format) - resource_categories#edit" do
                it {

                }
            end

            describe "GET - /resource_categories/:id(.:format) - resource_categories#show" do
                it {

                }
            end

            describe "PATCH - /resource_categories/:id(.:format) - resource_categories#update" do
                it {

                }
            end

            describe "PUT - /resource_categories/:id(.:format) - resource_categories#update" do
                it {

                }
            end

            describe "DELETE - /resource_categories/:id(.:format) - resource_categories#destroy" do
                it {

                }
            end
        end

        describe "Logged in as User:" do
            let(:user) { FactoryBot.create(:user) }
            before(:each) { sign_in user }

            describe "PATCH - /resource_categories/:id/activate(.:format) - resource_categories#activate" do
                it {

                }
            end

            describe "PATCH - /resource_categories/:id/deactivate(.:format) - resource_categories#deactivate" do
                it {

                }
            end

            describe "GET - /resource_categories(.:format) - resource_categories#index" do
                it {
                    expect(get(:index)).to redirect_to dashboard_path
                }
            end

            describe "POST - /resource_categories(.:format) - resource_categories#create" do
                it {
                    post(:create, params: { resource_category: FactoryBot.attributes_for(:resource_category) })
                    expect(response).to redirect_to dashboard_path
                }
            end

            describe "GET - /resource_categories(.:format) - resource_categories#new" do
                it {
                    expect(get(:new)).to redirect_to dashboard_path
                }
            end

            describe "GET - /resource_categories/:id/edit(.:format) - resource_categories#edit" do
                it {

                }
            end

            describe "GET - /resource_categories/:id(.:format) - resource_categories#show" do
                it {

                }
            end

            describe "PATCH - /resource_categories/:id(.:format) - resource_categories#update" do
                it {

                }
            end

            describe "PUT - /resource_categories/:id(.:format) - resource_categories#update" do
                it {

                }
            end

            describe "DELETE - /resource_categories/:id(.:format) - resource_categories#destroy" do
                it {

                }
            end
        end

        describe "Logged in as Admin:" do
            let(:user) { FactoryBot.create(:user, :admin) }
            before(:each) { sign_in user }

            describe "PATCH - /resource_categories/:id/activate(.:format) - resource_categories#activate" do
                it {

                }
            end

            describe "PATCH - /resource_categories/:id/deactivate(.:format) - resource_categories#deactivate" do
                it {

                }
            end

            describe "GET - /resource_categories(.:format) - resource_categories#index" do
                it {
                    expect(get(:index)).to be_successful
                }
            end

            describe "POST - /resource_categories(.:format) - resource_categories#create" do
                it {
                    post(:create, params: { resource_category: FactoryBot.attributes_for(:resource_category) })
                    expect(response).to redirect_to resource_categories_path
                }
            end

            describe "GET - /resource_categories(.:format) - resource_categories#new" do
                it {
                    expect(get(:new)).to be_successful
                }
            end

            describe "GET - /resource_categories/:id/edit(.:format) - resource_categories#edit" do
                it {

                }
            end

            describe "GET - /resource_categories/:id(.:format) - resource_categories#show" do
                it {

                }
            end

            describe "PATCH - /resource_categories/:id(.:format) - resource_categories#update" do
                it {

                }
            end

            describe "PUT - /resource_categories/:id(.:format) - resource_categories#update" do
                it {

                }
            end

            describe "DELETE - /resource_categories/:id(.:format) - resource_categories#destroy" do
                it {

                }
            end
        end
    end
end
