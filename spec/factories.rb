FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Fake #{n}" }
    sequence(:email) { |n| "fake#{n}@fake.fake"}   
    password "fakefake"
    password_confirmation "fakefake"
    
    #to use FactoryGirl.create(:admin) to create an administrative user in tests
    factory :admin do
      admin true
    end
  end
end
