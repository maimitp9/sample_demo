namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Maimit",
                 email: "maimitp9@gmail.com",
                 password: "123",
                 password_confirmation: "123",
                 admin: 'true')
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "123"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
