class CreateSpeakers < ActiveRecord::Migration[7.1]
  def change
    create_table :speakers do |t|
      t.string :name
      t.text :bio
      t.string :phone
      t.string :email
      t.bigint :event_id

      t.timestamps
    end
  end
end
