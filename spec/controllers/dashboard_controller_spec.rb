require 'rails_helper'

# GET    /dashboard(.:format)         dashboard#index

RSpec.describe DashboardController, type: :controller do
    describe "Dashboard Controller" do
        describe "Logged Out:" do
            let(:user) { FactoryBot.create(:user) }

            describe "GET - /dashboard(.:format) - dashboard#index" do
                it {
                    get(:index) 
                    expect(response).to redirect_to new_user_session_path
                }
            end
        end

        describe "Logged in as User:" do
            let(:user) { FactoryBot.create(:user, :organization_approved) }
            before(:each) { sign_in user }
            let(:ticket) { FactoryBot.create(:ticket, organization_id: user.organization_id) }

            describe "GET - /dashboard(.:format) - dashboard#index" do
                it {
                    get(:index)
                    expect(response).to be_successful
                }
            end

            describe "GET #index filtering by status" do
                context "when status is 'Open'" do
                    before do
                        allow(Ticket).to receive(:open).and_return(Ticket.all)
                        allow(controller).to receive(:pagy).and_return([:pagy, ['open_ticket']])
                        get(:index, params: { status: 'Open' })
                    end

                    it "assigns tickets from Ticket.open" do
                        expect(assigns(:tickets)).to eq(['open_ticket'])
                    end
                end

                context "when status is 'Closed'" do
                    before do
                        allow(Ticket).to receive(:closed).and_return(Ticket.all)
                        allow(controller).to receive(:pagy).and_return([:pagy, ['closed_ticket']])
                        get(:index, params: { status: 'Closed' })
                    end

                    it "assigns tickets from Ticket.closed" do
                        expect(assigns(:tickets)).to eq(['closed_ticket'])
                    end
                end

                context "when status is 'Captured'" do
                    before do
                        allow(Ticket).to receive(:all_organization).and_return(Ticket.all)
                        allow(controller).to receive(:pagy).and_return([:pagy, ['captured_ticket']])
                        get(:index, params: { status: 'Captured' })
                    end

                    it "assigns tickets from Ticket.all_organization" do
                        expect(assigns(:tickets)).to eq(['captured_ticket'])
                    end
                end

                context "when status is 'My Captured'" do
                    before do
                        allow(Ticket).to receive(:organization).with(user.organization.id).and_return(Ticket.all)
                        allow(controller).to receive(:pagy).and_return([:pagy, ['my_captured_ticket']])
                        get(:index, params: { status: 'My Captured' })
                    end

                    it "assigns tickets from Ticket.organization" do
                        expect(assigns(:tickets)).to eq(['my_captured_ticket'])
                    end
                end

                context "when status is 'My Closed'" do
                    before do
                        allow(Ticket).to receive(:closed_organization).with(user.organization.id).and_return(Ticket.all)
                        allow(controller).to receive(:pagy).and_return([:pagy, ['my_closed_ticket']])
                        get(:index, params: { status: 'My Closed' })
                    end

                    it "assigns tickets from Ticket.closed_organization" do
                        expect(assigns(:tickets)).to eq(['my_closed_ticket'])
                    end
                end

                context "when no matching status is provided" do
                    before do
                        allow(Ticket).to receive(:all).and_return(Ticket.all)
                        allow(controller).to receive(:pagy).and_return([:pagy, ['default_ticket']])
                        get(:index, params: { status: 'Nonexistent' })
                    end

                    it "assigns tickets from Ticket.all" do
                        expect(assigns(:tickets)).to eq(['default_ticket'])
                    end
                end
            end

            describe "GET #index assigns status_options" do
                it "returns organization approved user's options" do
                    get(:index)
                    expect(assigns(:status_options)).to eq(['Open', 'My Captured', 'My Closed'])
                end
            end
        end

        describe "Logged in as Non-approved Organization User:" do
            let(:non_approved_org) { FactoryBot.create(:organization, :status_rejected) }
            let(:user) { FactoryBot.create(:user, organization: non_approved_org) }
            before(:each) { sign_in user }
            
            describe "GET #index assigns status_options" do
                it "returns default ['Open']" do
                    get(:index)
                    expect(assigns(:status_options)).to eq(['Open'])
                end
            end
        end

        describe "Logged in as Admin:" do
            let(:user) { FactoryBot.create(:user, :admin) }
            before(:each) { sign_in user }
            let(:ticket) { FactoryBot.create(:ticket) }

            describe "GET - /dashboard(.:format) - dashboard#index" do
                it {
                    get(:index)
                    expect(response).to be_successful
                }
            end

            describe "GET #index assigns status_options" do
                it "returns admin user's options" do
                    get(:index)
                    expect(assigns(:status_options)).to eq(['Open', 'Captured', 'Closed'])
                end
            end

            describe "GET #index filtering by status" do
                context "when status is 'Open'" do
                    before do
                        allow(Ticket).to receive(:open).and_return(Ticket.all)
                        allow(controller).to receive(:pagy).and_return([:pagy, ['open_ticket']])
                        get(:index, params: { status: 'Open' })
                    end
                    it "assigns tickets from Ticket.open" do
                        expect(assigns(:tickets)).to eq(['open_ticket'])
                    end
                end

                context "when status is 'Closed'" do
                    before do
                        allow(Ticket).to receive(:closed).and_return(Ticket.all)
                        allow(controller).to receive(:pagy).and_return([:pagy, ['closed_ticket']])
                        get(:index, params: { status: 'Closed' })
                    end
                    it "assigns tickets from Ticket.closed" do
                        expect(assigns(:tickets)).to eq(['closed_ticket'])
                    end
                end

                context "when status is 'Captured'" do
                    before do
                        allow(Ticket).to receive(:all_organization).and_return(Ticket.all)
                        allow(controller).to receive(:pagy).and_return([:pagy, ['captured_ticket']])
                        get(:index, params: { status: 'Captured' })
                    end
                    it "assigns tickets from Ticket.all_organization" do
                        expect(assigns(:tickets)).to eq(['captured_ticket'])
                    end
                end

                context "when status is 'My Captured'" do
                    before do
                        allow(Ticket).to receive(:organization).with(user.organization&.id).and_return(Ticket.all)
                        allow(controller).to receive(:pagy).and_return([:pagy, ['my_captured_ticket']])
                        get(:index, params: { status: 'My Captured' })
                    end
                    it "assigns tickets from Ticket.organization" do
                        expect(assigns(:tickets)).to eq(['my_captured_ticket'])
                    end
                end

                context "when status is 'My Closed'" do
                    before do
                        allow(Ticket).to receive(:closed_organization).with(user.organization&.id).and_return(Ticket.all)
                        allow(controller).to receive(:pagy).and_return([:pagy, ['my_closed_ticket']])
                        get(:index, params: { status: 'My Closed' })
                    end
                    it "assigns tickets from Ticket.closed_organization" do
                        expect(assigns(:tickets)).to eq(['my_closed_ticket'])
                    end
                end

                context "when no matching status is provided" do
                    before do
                        allow(Ticket).to receive(:all).and_return(Ticket.all)
                        allow(controller).to receive(:pagy).and_return([:pagy, ['default_ticket']])
                        get(:index, params: { status: 'Nonexistent' })
                    end
                    it "assigns tickets from Ticket.all" do
                        expect(assigns(:tickets)).to eq(['default_ticket'])
                    end
                end
            end
        end
    end
end
