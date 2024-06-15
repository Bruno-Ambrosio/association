class AddIndexToPeopleActive < ActiveRecord::Migration[6.0]
    def change
      add_index :people, :active
    end
  end
  