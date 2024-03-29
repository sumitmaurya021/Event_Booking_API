class AddUserIdToTickets < ActiveRecord::Migration[7.1]
  def change
    add_reference :tickets, :user, foreign_key: true
    change_column_null :tickets, :user_id, true
  end
end
