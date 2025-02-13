FactoryBot.define do
    sequence :email do |n|
      "fake#{n}@factory.com"
    end
  
    sequence :name do |n|
      "fake_#{n}"
    end

    sequence :organization_id do |n|
        "#{n}"
    end

    sequence :phone do |n|
        "+1-555-555-#{n.to_s.rjust(4, '0')}"
    end
  end