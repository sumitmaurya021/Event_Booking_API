class RemoveSpeakerIdInEvent < ActiveRecord::Migration[7.1]
  def change
    remove_column :events, :speaker_id
  end
end
