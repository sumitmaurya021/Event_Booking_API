# spec/factories/access_tokens.rb

FactoryBot.define do
  factory :access_token, class: 'Doorkeeper::AccessToken' do
    association :resource_owner, factory: :user
    sequence(:token) { |n| "access-token-#{n}" }
    expires_in { 2.hours }
  end
end
