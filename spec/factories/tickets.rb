FactoryBot.define do
    factory :ticket do
        name { "Ticket" }
        phone { "+1-555-555-1212" }
        region
        resource
        organization_id { 1 }
        closed { false }
    end
end