# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.logger = Logger.new(STDOUT)

User.delete_all
User.connection.execute("delete from sqlite_sequence where name='users'")
User.create([{
  name: "Masamoto Miyata",
  email: "miyata@sincere-co.com",
  password: "111111",
  admin: true
}])


99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end