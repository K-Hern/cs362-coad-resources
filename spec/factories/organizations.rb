FactoryBot.define do

    factory :organization do
        name { "Organization Name" }
        email { "test@email.com" }
        phone {"541-280-2937"}
        status {"submitted"}
        primary_name {"uniquename"}
        secondary_name {"test"}
        secondary_phone {"123-123-1234"}
    end
    
end