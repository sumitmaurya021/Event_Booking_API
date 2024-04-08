FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
    username { Faker::Internet.username }
    phone { "7649876578" }
    account_status { 'active' }
  end
end
