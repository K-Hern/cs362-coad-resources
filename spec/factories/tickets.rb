FactoryBot.define do
    factory :ticket do
        name  # defined as a sequence
        phone   # defined as a sequence
        region
        resource_category
        # organization_id  # defined as a sequence

        trait :ticket_open do
            closed { false }
        end

        trait :ticket_closed do
            closed { true }
        end

        trait :captured do
            closed { false }
            transient do
                org_id { create(:organization).id }
            end
      
            organization_id { org_id }
        end
    end
end