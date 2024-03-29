class AddTicketNumberToTickets < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :ticket_number, :string
  end
end
