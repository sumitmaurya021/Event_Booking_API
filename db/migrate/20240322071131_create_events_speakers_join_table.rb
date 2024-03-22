class CreateEventsSpeakersJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :events_speakers, id: false do |t|
      t.belongs_to :event
      t.belongs_to :speaker
    end

    add_index :events_speakers, [:event_id, :speaker_id], unique: true
  end
end
