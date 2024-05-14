class Debt < ApplicationRecord
  belongs_to :person
  validates :amount, presence: true
  self.per_page = 50

  after_create :person_update_balance

  def person_update_balance
    person.update_balance! if person.present?
  end
end
