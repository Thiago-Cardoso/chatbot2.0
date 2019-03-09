FactoryBot.define do    
    factory :faq do       
      question { FFaker::Lorem.phrase }       
      answer { FFaker::Lorem.phrase }
    end
end