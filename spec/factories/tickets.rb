FactoryBot.define do
    factory :ticket do
        name  # defined as a sequence
        phone   # defined as a sequence
        region
        resource_category
        organization_id  # defined as a sequence
        closed { false }
    end
end