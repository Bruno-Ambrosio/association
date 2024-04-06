class AddObservationToPayments < ActiveRecord::Migration[7.1]
  def change
    add_column :payments, :observation, :text
  end
end
