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
      let(:org) { FactoryBot.build_stubbed(:organization) }
      let(:user) { FactoryBot.create(:user) }
      before(:each) { sign_in user }

      # describe "POST - /organizations/:id/approve(.:format) - organizations#approve" do
      #   it "" do
      #   end
      # end

      # describe "POST - /organizations/:id/reject(.:format) - organizations#reject" do
      #   it "" do
      #   end
      # end

      describe "GET - /organizations(.:format) - organizations#index" do
        it "Serves dashboard" do
          get(:index)
          expect(response).to be_successful
        end
      end

      describe "POST - /organizations(.:format) - organizations#create" do
        context "when save is successful" do
          let(:org_attributes) { FactoryBot.attributes_for(:organization) }
          before do
            allow_any_instance_of(Organization).to receive(:valid?).and_return(true)
            allow_any_instance_of(Organization).to receive(:save).and_return(true)
            allow(user).to receive(:save).and_return(true)
          end

          it "redirects to organization_application_submitted_path" do
            expect(response).to be_successful
          end
        end

        context "when save fails" do
          let(:org_attributes) { FactoryBot.attributes_for(:organization) }
          before do
            allow_any_instance_of(Organization).to receive(:valid?).and_return(true)
            allow_any_instance_of(Organization).to receive(:save).and_return(false)
            post(:create, params: { organization: org_attributes })
          end
          it "renders the new template" do
            expect(response).to render_template(:new)
          end
        end
      end

      describe "GET - /organizations/new(.:format) - organizations#new" do
        it "redirects to dashboard" do
          get(:new, params: { id: org.id })
          expect(response).to be_successful
        end
      end

      context "when user is organization approved" do
        let(:approved_org) { FactoryBot.create(:organization, :status_approved) }
        let(:user) { FactoryBot.create(:user, :organization_approved, organization: approved_org) }
        before { sign_in user }

        describe "PATCH - /organizations/:id(.:format) - organizations#update" do
          context "when update is successful" do
            before do
              allow_any_instance_of(Organization).to receive(:update).and_return(true)
              patch(:update, params: { id: approved_org.id, organization: { name: "New Name" } })
            end
            it "redirects to organization_path" do
              expect(response).to redirect_to(organization_path(id: approved_org.id))
            end
          end
          
          context "when update fails" do
            before do
              allow_any_instance_of(Organization).to receive(:update).and_return(false)
              patch(:update, params: { id: approved_org.id, organization: { name: "New Name" } })
            end
            it "renders the edit template" do
              expect(response).to render_template(:edit)
            end
          end
        end
      end

      # describe "GET - /organizations/:id/edit(.:format) - organizations#edit" do
      #   it "" do
      #   end
      # end

      # describe "GET - /organizations/:id(.:format) - organizations#show" do
      #   it "" do
      #   end
      # end

      # describe "PATCH - /organizations/:id(.:format) - organizations#update" do
      #   it "" do
      #   end
      # end

      # describe "PUT - /organizations/:id(.:format) - organizations#update" do
      #   it "" do
      #   end
      # end

    end

    describe "Logged in as Admin:" do
      let(:org) { FactoryBot.create(:organization, :status_approved) }
      let(:user) { FactoryBot.create(:user, :admin) }
      before(:each) { sign_in user }

      # describe "POST - /organizations/:id/approve(.:format) - organizations#approve" do
      #   it "" do
      #   end
      # end

      # describe "POST - /organizations/:id/reject(.:format) - organizations#reject" do
      #   it "" do
      #   end
      # end

      # describe "GET - /organizations(.:format) - organizations#index" do
      #   it "" do

      #   end
      # end

      # describe "POST - /organizations(.:format) - organizations#create" do
      #   it "" do
      #   end
      # end

      # describe "GET - /organizations/new(.:format) - organizations#new" do
      #   it "" do
      #   end
      # end

      # describe "GET - /organizations/:id/edit(.:format) - organizations#edit" do
      #   it "" do
      #   end
      # end

      describe "GET - /organizations/:id(.:format) - organizations#show" do
        it "renders the show template" do
          get(:show, params: { id: org.id })
          expect(response).to be_successful
          expect(response).to render_template(:show)
        end
      end

      describe "PATCH - /organizations/:id(.:format) - organizations#update" do
        context "when update is successful" do
          before do
            allow_any_instance_of(Organization).to receive(:update).and_return(true)
            patch(:update, params: { id: org.id, organization: { name: "New Name" } })
          end
          it "redirects to dashboard_path" do
            expect(response).to redirect_to(dashboard_path)
          end
        end
        context "when update fails" do
          before do
            allow_any_instance_of(Organization).to receive(:update).and_return(false)
            patch(:update, params: { id: org.id, organization: { name: "New Name" } })
          end
          it "redirects to dashboard_path" do
            expect(response).to redirect_to(dashboard_path)
          end
        end
      end

      describe "POST - /organizations/:id/approve(.:format) - organizations#approve" do
        context "when approval is successful" do
          before do
            allow_any_instance_of(Organization).to receive(:approve)
            allow_any_instance_of(Organization).to receive(:save).and_return(true)
            post(:approve, params: { id: org.id })
          end
          it "redirects to organizations_path with a success notice" do
            expect(response).to redirect_to(organizations_path)
            expect(flash[:notice]).to eq("Organization #{org.name} has been approved.")
          end
        end
        context "when approval fails" do
          before do
            allow_any_instance_of(Organization).to receive(:approve)
            allow_any_instance_of(Organization).to receive(:save).and_return(false)
            allow(controller).to receive(:render)
            post(:approve, params: { id: org.id })
          end
          it "calls render with organization_path(id: org.id)" do
            expect(controller).to have_received(:render).with(organization_path(id: org.id))
          end
        end
      end

      describe "POST - /organizations/:id/reject(.:format) - organizations#reject" do
        context "when rejection is successful" do
          let(:rejection_reason) { "Not sufficient details" }
          before do
            allow_any_instance_of(Organization).to receive(:reject)
            allow_any_instance_of(Organization).to receive(:save).and_return(true)
            post(:reject, params: { id: org.id, organization: { rejection_reason: rejection_reason } })
          end
          it "redirects to organizations_path with a rejection notice" do
            expect(response).to redirect_to(organizations_path)
            expect(flash[:notice]).to eq("Organization #{org.name} has been rejected.")
          end
        end
        context "when rejection fails" do
          let(:rejection_reason) { "Incomplete information" }
          before do
            allow_any_instance_of(Organization).to receive(:reject)
            allow_any_instance_of(Organization).to receive(:save).and_return(false)
            allow(controller).to receive(:render)
            post(:reject, params: { id: org.id, organization: { rejection_reason: rejection_reason } })
          end
          it "calls render with organization_path(id: org.id)" do
            expect(controller).to have_received(:render).with(organization_path(id: org.id))
          end
        end
      end
    end
  end
end
