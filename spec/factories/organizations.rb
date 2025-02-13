FactoryBot.define do

    factory :organization do
        name  # defined as a sequence
        email  # defined as a sequence
        phone  # defined as a sequence
        primary_name { name }  # defined as a sequence
        secondary_name { name }  # defined as a sequence
        secondary_phone { phone }  # defined as a sequence

        trait :status_approved do
            status { "approved" }
        end

        trait :status_rejected do
            status { "rejected" }
        end

        trait :status_submitted do
            status { "submitted" }
        end
    end
    
end