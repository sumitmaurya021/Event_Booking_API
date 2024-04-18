FactoryBot.define do
  factory :event do
    event_name { Faker::Name.name }
    date { Faker::Date.between(from: '2022-01-01', to: '2022-12-31') }
    time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    location { Faker::Address.full_address }
    agenda { Faker::Lorem.paragraph(sentence_count: 2) }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    total_tickets { Faker::Number.between(from: 1, to: 200) }
    ticket_price { Faker::Commerce.price }
    total_seats { Faker::Number.between(from: 50, to: 200) }
  end
end
