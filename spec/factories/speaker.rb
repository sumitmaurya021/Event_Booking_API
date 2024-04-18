FactoryBot.define do
  factory :speaker do
    name { Faker::Name.name }
    bio { Faker::Lorem.paragraph(sentence_count: 2) }
    phone { "7649876578" }
    email { Faker::Internet.email }
  end
end
