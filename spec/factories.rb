FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Fake #{n}" }
    sequence(:email) { |n| "fake#{n}@fake.fake" } 
    password "fakefake"
    password_confirmation "fakefake"
    
    factory :admin do
      admin true
    end
  end
end
