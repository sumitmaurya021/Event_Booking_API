class AddSpeakerIdInEvent < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :speaker_id, :bigint
  end
end
