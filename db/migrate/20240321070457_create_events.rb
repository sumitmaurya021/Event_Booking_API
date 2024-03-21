class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :event_name
      t.text :agenda
      t.text :description
      t.date :date
      t.time :time
      t.string :location
      t.integer :total_tickets
      t.decimal :ticket_price
      t.integer :total_seats
      t.bigint :user_id

      t.timestamps
    end
  end
end
