require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'associations' do
    it { should belong_to(:user).optional }
    it { should have_many(:debts) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:national_id) }
    it { should validate_uniqueness_of(:national_id) }
  end

  describe 'custom validations' do
    it 'should validate cpf_or_cnpj' do
      person = Person.new(name: 'John Doe', national_id: CPF.generate)
      expect(person).to be_valid

      person.national_id = CPF.generate
      expect(person).to be_valid

      person.national_id = 'invalid_id'
      expect(person).not_to be_valid
    end
  end

  describe '#total_debts' do
    it 'returns the sum of all debt amounts' do
      person = Person.new(name: 'John Doe', national_id: CPF.generate)
      person.save!  # Ensure person is saved to generate an id
  
      person.debts.create!(amount: 700)
      person.debts.create!(amount: 200)
      person.debts.create!(amount: 300)
  
      expect(person.total_debts).to eq(1200) 
    end

    it 'returns 0 if there are no debts' do
      person = Person.new(name: 'John Doe', national_id: CPF.generate)

      expect(person.total_debts).to eq(0)
    end
  end

  describe '#total_payments' do
    it 'returns the sum of all total_payments' do
      person = Person.new(name: 'John Doe', national_id: CPF.generate)
      person.save!
      person.payments.create!(amount: 200)
      person.payments.create!(amount: 400)
      person.payments.create!(amount: 100)

      expect(person.total_payments).to eq(700)
    end

    it 'returns 0 if there are no payments' do
      person = Person.new(name: 'John Doe', national_id: CPF.generate)

      expect(person.total_payments).to eq(0)
    end
  end

  describe '#total_balance' do
    it 'returns the sum of all balance amounts' do
      person = Person.create(name: 'Doe', national_id: CPF.generate)
      person.save!
      person.debts.create!(amount: 400)
      person.payments.create!(amount: 100)

      expect(person.total_balance).to eq(-300)
    end

    it 'returns 0 if there are no balance' do
      person = Person.new(name: 'Geremias', national_id: CPF.generate)

      expect(person.total_balance).to eq(0)
    end
  end
end
