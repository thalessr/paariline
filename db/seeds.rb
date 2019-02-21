# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
client = RandomUser::Client.new

client.quantity = 8
client.profiles.each do |profile|
  user = User.new
  user.new_pictures = profile.picture_large
  user.email = profile.email
  user.age = profile.age
  user.password = profile.password
  user.password_confirmation = profile.password
  user.city = profile.city
  user.first_name = profile.first_name
  user.last_name = profile.last_name
  user.birth_date = profile.birth_date
  user.save!
end

# Create admin user
Admin.create!(email: 'admin@paariline.ee', password: 'password', password_confirmation: 'password')
