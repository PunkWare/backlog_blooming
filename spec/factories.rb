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
  
  factory :task do
    sequence(:code)   { |n| "T#{n}" }
    sequence(:title)  { |n| "Task number #{n}" }
    remaining_effort 10
    user
  end
end
