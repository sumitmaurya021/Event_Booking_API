class DeleteEventIdFromSpeaker < ActiveRecord::Migration[7.1]
  def change
    remove_column :speakers, :event_id
  end
end
