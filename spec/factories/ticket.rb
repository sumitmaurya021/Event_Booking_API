FactoryBot.define do
  factory :ticket do
    event_id { 1 }
    user_id { 1 }
    price { 100 }
    ticket_number { "MyString" }
    booking_id { 1 }

    event
    booking
    user
  end
end
