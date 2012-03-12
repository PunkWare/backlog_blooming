FactoryGirl.define do
  factory :user do
    name  "Fake"
    email "fake@fake.fake"
    password "fakefake"
    password_confirmation "fakefake"
  end
end