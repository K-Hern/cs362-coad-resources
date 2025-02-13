FactoryBot.define do
    factory :ticket do
        name  # defined as a sequence
        phone   # defined as a sequence
        region
        resource_category
        organization_id  # defined as a sequence

        trait :ticket_open do
            closed { false }
        end

        trait :ticket_closed do
            closed { true }
        end
    end
end