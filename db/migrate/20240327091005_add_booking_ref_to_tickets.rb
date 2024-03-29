class AddBookingRefToTickets < ActiveRecord::Migration[7.1]
  def change
    add_reference :tickets, :booking, null: false, foreign_key: true
  end
end
