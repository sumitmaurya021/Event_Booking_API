class CreateEventAnalytics < ActiveRecord::Migration[7.1]
  def change
    create_table :event_analytics do |t|
      t.references :event, null: false, foreign_key: true
      t.integer :tickets_sold
      t.decimal :revenue
      t.integer :attendance_count

      t.timestamps
    end
  end
end
