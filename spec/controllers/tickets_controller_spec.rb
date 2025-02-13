require 'rails_helper'

# POST   /tickets(.:format)                     tickets#create
# GET    /tickets/new(.:format)                 tickets#new
# GET    /tickets/:id(.:format)                 tickets#show        # mock required
# POST   /tickets/:id/capture(.:format)         tickets#capture     # mock required  # unit states (context) required
# POST   /tickets/:id/release(.:format)         tickets#release     # mock required  # unit states (context) required
# PATCH  /tickets/:id/close(.:format)           tickets#close       # mock required  # unit states (context) required
# DELETE /tickets/:id(.:format)                 tickets#destroy     # mock required  # unit states (context) required

RSpec.describe TicketsController, type: :controller do
    describe "Ticket Controller" do
        describe "Logged Out:" do
            let(:user) { FactoryBot.create(:user) }

            describe "POST - /tickets(.:format) - tickets#create" do
                it {
                    post(:create, params: { ticket: FactoryBot.attributes_for(:ticket) })
                    expect(response).to be_successful
                }
            end

            describe "GET - /tickets(.:format) - tickets#new" do
                it { 
                    expect(get(:new)).to be_successful 
                }
            end

            # describe "GET - /tickets/:id(.:format) - tickets#show" do  # mocked ticket required, should not be able to get here without being logged in so that might be while this mock does not work...?
            #     let(:ticket) { FactoryBot.create(:ticket) }
            #     it "redirects to ticket of specific id" do
            #         get(:show, params: { id: ticket.id })
            #         expect(response).to redirect_to dashboard_path
            #     end
            # end
        end
    
        describe "Logged in as User:" do
            let(:user) { FactoryBot.create(:user) }
            before(:each) { sign_in user }
        
            describe "POST - /tickets(.:format) - tickets#create" do
                it {
                    post(:create, params: { ticket: FactoryBot.attributes_for(:ticket) })
                    expect(response).to be_successful
                }
            end

            describe "GET - /tickets(.:format) - tickets#new" do
                it { 
                    expect(get(:new)).to be_successful 
                }
            end

            # DOES NOT WORK CORRECTLY
            # describe "GET - /tickets/:id(.:format) - tickets#show" do  # mocked ticket required, should not be able to get here without being logged in so that might be while this mock does not work...?
            #     let(:ticket) { FactoryBot.create(:ticket) }
            #     let(:organization) { FactoryBot.build_stubbed(organization_id: ticket.id)}
            #     it "redirects to ticket of specific id" do
            #         get(:show, params: { id: ticket.id })
            #         expect(response).to redirect_to dashboard_path
            #     end
            # end
        end
        
        describe "Logged in as Admin:" do
            let(:user) { FactoryBot.create(:user, :admin) }
            before(:each) { sign_in user }
        
            describe "POST - /tickets(.:format) - tickets#create" do
                it {
                    post(:create, params: { ticket: FactoryBot.attributes_for(:ticket) })
                    expect(response).to be_successful
                }
            end

            describe "GET - /tickets(.:format) - tickets#new" do
                it { 
                    expect(get(:new)).to be_successful 
                }
            end

            describe "GET - /tickets/:id(.:format) - tickets#show" do  # mocked ticket required
                let(:ticket) { FactoryBot.create(:ticket) }
                it "redirects to ticket of specific id" do
                    get(:show, params: { id: ticket.id })
                    expect(response).to be_successful
                end
            end
        end
    end
end
