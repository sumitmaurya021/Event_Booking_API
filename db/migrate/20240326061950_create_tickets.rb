class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.references :event, null: false, foreign_key: true
      t.integer :status, default: 0
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
