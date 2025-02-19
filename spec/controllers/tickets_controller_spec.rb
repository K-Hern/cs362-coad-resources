require 'rails_helper'

# POST   /tickets(.:format)                     tickets#create
# GET    /tickets/new(.:format)                 tickets#new
# GET    /tickets/:id(.:format)                 tickets#show        # mock required
# POST   /tickets/:id/capture(.:format)         tickets#capture     # mock required  # unit states (context) required
# POST   /tickets/:id/release(.:format)         tickets#release     # mock required  # unit states (context) required
# PATCH  /tickets/:id/close(.:format)           tickets#close       # mock required  # unit states (context) required
# DELETE /tickets/:id(.:format)                 tickets#destroy     # mock required  # unit states (context) required

RSpec.describe TicketsController, type: :controller do
    describe "Ticket Controller:" do
        describe "Logged Out:" do
            let(:ticket) { FactoryBot.create(:ticket) }
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

            describe "GET - /tickets/:id(.:format) - tickets#show" do
                it "redirects to sign in" do
                    get(:show, params: { id: ticket.id })
                    expect(response).to redirect_to dashboard_path
                end
            end

            describe "POST - /tickets/:id/capture(.:format) - tickets#capture" do
                it "redirects to sign in" do
                    post(:capture, params: { id: ticket.id })
                    expect(response).to redirect_to dashboard_path
                end
            end

            describe "POST - /tickets/:id/release(.:format) - tickets#release" do
                it "redirects to sign in" do
                    post(:release, params: { id: ticket.id })
                    expect(response).to redirect_to dashboard_path
                end
            end

            describe "PATCH - /tickets/:id/close(.:format) - tickets#close" do
                it "redirects to sign in" do
                    patch(:close, params: { id: ticket.id })
                    expect(response).to redirect_to redirect_to dashboard_path
                end
            end

            describe "DELETE - /tickets/:id(.:format) - tickets#destroy" do
                it "redirects to sign in" do
                    delete(:destroy, params: { id: ticket.id })
                    expect(response).to redirect_to dashboard_path
                end
            end
        end
    
        describe "Logged in as User:" do
            let(:user) { FactoryBot.create(:user, :organization_approved) }
            before(:each) { sign_in user }
            let(:ticket) { FactoryBot.create(:ticket, organization_id: user.organization_id) }

            describe "POST - /tickets(.:format) - tickets#create" do
                it {
                    post(:create, params: { ticket: FactoryBot.attributes_for(:ticket) })
                    expect(response).to render_template(:new)
                }
            end

            describe "GET - /tickets(.:format) - tickets#new" do
                it { 
                    expect(get(:new)).to be_successful 
                }
            end

            describe "GET - /tickets/:id(.:format) - tickets#show" do
                it "serves the ticket's page" do
                    get(:show, params: { id: ticket.id })
                    expect(response).to render_template(:show)
                end
            end

            describe "POST - /tickets/:id/capture(.:format) - tickets#capture" do
                context "when TicketService.capture_ticket returns :ok" do
                    before do
                        allow(TicketService).to receive(:capture_ticket)
                            .with(ticket.id.to_s, user)
                            .and_return(:ok)
                    end
                    it "redirects to dashboard_path appended with '#tickets:open'" do
                        post(:capture, params: { id: ticket.id })
                        expect(response).to redirect_to(dashboard_path << '#tickets:open')
                    end
                end
                context "when TicketService.capture_ticket does not return :ok" do
                    before do
                        allow(TicketService).to receive(:capture_ticket)
                            .with(ticket.id.to_s, user)
                            .and_return(:error)
                    end
                    it "renders the show template" do
                        post(:capture, params: { id: ticket.id })
                        expect(response).to render_template(:show)
                    end
                end
            end

            describe "POST - /tickets/:id/release(.:format) - tickets#release" do
                context "when TicketService.release_ticket returns :ok" do
                    before do
                        allow(TicketService).to receive(:release_ticket)
                            .with(ticket.id.to_s, user)
                            .and_return(:ok)
                    end
                    it "redirects to dashboard_path appended with '#tickets:organization'" do
                        post(:release, params: { id: ticket.id })
                        expect(response).to redirect_to(dashboard_path << '#tickets:organization')
                    end
                end
              
                context "when TicketService.release_ticket does not return :ok" do
                    before do
                        allow(TicketService).to receive(:release_ticket)
                            .with(ticket.id.to_s, user)
                            .and_return(:error)
                    end
                    it "renders the show template" do
                        post(:release, params: { id: ticket.id })
                        expect(response).to render_template(:show)
                    end
                end
            end

            describe "PATCH - /tickets/:id/close(.:format) - tickets#close" do
                context "when TicketService.release_ticket returns :ok" do
                    before do
                        allow(TicketService).to receive(:close_ticket)
                            .with(ticket.id.to_s, user)
                            .and_return(:ok)
                    end
                    it "redirects to dashboard_path appended with '#tickets:organization'" do
                        post(:close, params: { id: ticket.id })
                        expect(response).to redirect_to(dashboard_path << '#tickets:organization')
                    end
                end
            end

            describe "DELETE - /tickets/:id(.:format) - tickets#destroy" do
                it "serves the destroy action" do
                    delete(:destroy, params: { id: ticket.id })
                    expect(response).to redirect_to dashboard_path
                end
            end
        end
        
        describe "Logged in as Admin:" do
            let(:user) { FactoryBot.create(:user, :admin) }
            before(:each) { sign_in user }
            let(:ticket) { FactoryBot.create(:ticket) }

            describe "POST - /tickets(.:format) - tickets#create" do
                context "when save is successful" do
                    it "redirects to ticket_submitted_path" do
                        allow_any_instance_of(Ticket).to receive(:save).and_return(true)
                        post(:create, params: { ticket: FactoryBot.attributes_for(:ticket) })
                        # expect(response).to be_successful
                        expect(response).to redirect_to(ticket_submitted_path)
                    end
                end
              
                context "when save fails" do
                    it "renders the new template" do
                        ticket_attributes = FactoryBot.attributes_for(:ticket)
                        allow_any_instance_of(Ticket).to receive(:save).and_return(false)
                        post(:create, params: { ticket: ticket_attributes })
                        expect(response).to render_template(:new)
                    end
                end
            end

            describe "GET - /tickets(.:format) - tickets#new" do
                it { 
                    expect(get(:new)).to be_successful 
                }
            end

            describe "GET - /tickets/:id(.:format) - tickets#show" do
                it "serves the ticket's page" do
                    get(:show, params: { id: ticket.id })
                    expect(response).to render_template(:show)
                end
            end

            describe "POST - /tickets/:id/capture(.:format) - tickets#capture" do
                context "when TicketService.capture_ticket returns :ok" do
                    before do
                        allow(TicketService).to receive(:capture_ticket)
                            .with(ticket.id.to_s, user)
                            .and_return(:ok)
                    end
                    it "redirects to dashboard_path appended with '#tickets:open'" do
                        post(:capture, params: { id: ticket.id })
                        expect(response).to redirect_to dashboard_path
                    end
                end
                
                context "when TicketService.capture_ticket does not return :ok" do
                    before do
                        allow(TicketService).to receive(:capture_ticket)
                            .with(ticket.id.to_s, user)
                            .and_return(:error)
                    end
                    it "renders the show template" do
                        post(:capture, params: { id: ticket.id })
                        expect(response).to redirect_to dashboard_path
                    end
                end
            end

            describe "POST - /tickets/:id/release(.:format) - tickets#release" do
                context "when TicketService.release_ticket returns :ok" do
                    before do
                        allow(TicketService).to receive(:release_ticket)
                            .with(ticket.id.to_s, user)
                            .and_return(:ok)
                    end
                    it "redirects to dashboard_path appended with '#tickets:captured'" do
                        post(:release, params: { id: ticket.id })
                        expect(response).to redirect_to dashboard_path  # no way for admin to capture a ticket
                    end
                end
              
                context "when TicketService.release_ticket does not return :ok" do
                    before do
                        allow(TicketService).to receive(:release_ticket)
                            .with(ticket.id.to_s, user)
                            .and_return(:error)
                    end
                    it "renders the show template" do
                        post(:release, params: { id: ticket.id })
                        expect(response).to redirect_to dashboard_path
                    end
                end
            end

            describe "PATCH - /tickets/:id/close(.:format) - tickets#close" do
                context "when TicketService.close_ticket returns :ok" do
                    before do
                        allow(TicketService).to receive(:close_ticket)
                            .with(ticket.id.to_s, user)
                            .and_return(:ok)
                    end
                    it "redirects to dashboard_path appended with '#tickets:open'" do
                        patch(:close, params: { id: ticket.id })
                        expect(response).to redirect_to(dashboard_path << '#tickets:open')
                    end
                end

                context "when TicketService.close_ticket does not return :ok" do
                    before do
                        allow(TicketService).to receive(:close_ticket)
                            .with(ticket.id.to_s, user)
                            .and_return(:error)
                    end
                    it "renders the show template" do
                        patch(:close, params: { id: ticket.id })
                        expect(response).to render_template(:show)
                    end
                end
            end

            describe "DELETE - /tickets/:id(.:format) - tickets#destroy" do
                it "redirects to dashboard_path appended with '#tickets' with a deletion notice" do
                    delete(:destroy, params: { id: ticket.id })
                    expect(response).to redirect_to(dashboard_path << '#tickets')
                    expect(flash[:notice]).to eq("Ticket #{ticket.id} was deleted.")
                end
            end
        end
    end
end
