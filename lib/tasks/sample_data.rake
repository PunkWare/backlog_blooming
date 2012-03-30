namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!( name: "admin",
                          email: "backlogblooming@free.fr",
                          password: "Thomas",
                          password_confirmation: "Thomas")
    admin.toggle!(:admin)
    
    99.times do |n|
      name      = Faker::Name.name
      email     = "example-#{n+1}@free.fr"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    
    users = User.all(limit: 6)
      50.times do
      code              = Faker::Lorem.words(1).first 
      title             = Faker::Lorem.sentence(4)
      remaining_effort  = rand(0..20)
      users.each { |user| user.tasks.create!( code: code,
                                              title: title, 
                                              remaining_effort: remaining_effort) }
    end
  end
end