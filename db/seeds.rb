# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.destroy_all
Person.destroy_all
Debt.destroy_all

User.create(email: 'admin@admin.com', password: '123456') 
#People.create name: 'Admin', national_id: '11111111111', cpf_or_cnpj: '11111111111', active: true

1000.times do |counter|
  percent = (counter.to_f / 1000 * 100).to_i
  puts "creating user: #{counter}, #{percent}%"
    User.create(
      email: Faker::Internet.email,
      password: Faker::Internet.password
    )
end
user_ids = User.pluck(:id)

3000.times do |counter|
  percent = (counter.to_f / 3000 * 100).to_i
  puts "creating Person: #{counter}, #{percent}%"
    Person.create(
      name: Faker::Name.name,
      phone_number: Faker::PhoneNumber.phone_number,
      national_id: CPF.generate,
      active: Faker::Boolean.boolean(true_ratio: 0.5),
      user_id: user_ids.sample
    )
end
person_ids = Person.pluck(:id)

5000.times do |counter|
  percent = (counter.to_f / 5000 * 100).to_i
  puts "creating Debt: #{counter}, #{percent}%"
    Debt.create(
      person_id: person_ids.sample,
      amount: rand(1..1000),
      observation: Faker::Lorem.sentence
    )
end