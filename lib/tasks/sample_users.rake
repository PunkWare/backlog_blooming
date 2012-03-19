namespace :db do
  desc "Fill database with sample data"
  task populate_users: :environment do
    User.create!(name: "admin",
                 email: "backlogblooming@free.fr",
                 password: "Thomas",
                 password_confirmation: "Thomas")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@free.fr"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end