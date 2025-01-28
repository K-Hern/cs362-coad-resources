require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
    describe "full_title:" do
        it "returns the base title when page title is empty" do
            expect(helper.full_title("")).to eq("Disaster Resource Network")
        end

        it "returns the full title when page title is not empty" do
            expect(helper.full_title("Page_Title")).to eq("Page_Title | Disaster Resource Network")
        end
    end
end
