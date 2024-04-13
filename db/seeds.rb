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
Payment.destroy_all

users_data = []
people_data = []
debts_data = []
payments_data = []

User.create(email: 'admin@admin.com', password: '123456') 
1000.times do |counter|
  percent = (counter.to_f / 1000 * 100).to_i
  puts "creating user: #{counter}, #{percent}%"
  
  users_data << {
    email: Faker::Internet.email,
    encrypted_password: Faker::Internet.password
  }
end

# Inserindo todos os usuários de uma só vez usando insert_all
User.insert_all(users_data)

# Recupera todos os IDs dos usuários criados
user_ids = User.pluck(:id)

3000.times do |counter|
  percent = (counter.to_f / 3000 * 100).to_i
  puts "creating Person: #{counter}, #{percent}%"
  
  people_data << {
    name: Faker::Name.name,
    phone_number: Faker::PhoneNumber.phone_number,
    national_id: CPF.generate,
    active: Faker::Boolean.boolean(true_ratio: 0.5),
    user_id: user_ids.sample
  }
end

# Inserindo todas as pessoas de uma só vez usando insert_all
Person.insert_all(people_data)

# Recupera todos os IDs das pessoas criadas
person_ids = Person.pluck(:id)

5000.times do |counter|
  percent = (counter.to_f / 5000 * 100).to_i
  puts "creating Debt: #{counter}, #{percent}%"
  
  debts_data << {
    person_id: person_ids.sample,
    amount: rand(1..1000),
    observation: Faker::Lorem.sentence
  }
end

# Inserindo todas as dívidas de uma só vez usando insert_all
Debt.insert_all(debts_data)

5000.times do |counter|
  percent = (counter.to_f / 5000 * 100).to_i
  puts "creating Payment: #{counter}, #{percent}%"
  
  payments_data << {
    person_id: person_ids.sample,
    amount: rand(1..1000),
    observation: Faker::Lorem.sentence
  }
end

# Inserindo todos os pagamentos de uma só vez usando insert_all
Payment.insert_all(payments_data)