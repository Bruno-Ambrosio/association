class Person < ApplicationRecord
  belongs_to :user, optional: true

  has_many :debts, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates :name, :national_id, presence: true
  validates :national_id, uniqueness: true
  validate :cpf_or_cnpj
  self.per_page = 50

  def person_debts
    -debts.sum(:amount)
  end
  
  def person_payments
    payments.sum(:amount)
  end

  def update_balance!
    update(balance: person_debts + person_payments)
  end

  private

  def cpf_or_cnpj
    if !CPF.valid?(national_id) && !CNPJ.valid?(national_id)
      errors.add :national_id, :invalid
    end
  end
end