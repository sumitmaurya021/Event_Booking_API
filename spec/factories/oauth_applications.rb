# spec/factories/oauth_applications.rb

FactoryBot.define do
  factory :oauth_application, class: 'Doorkeeper::Application' do
    sequence(:name) { |n| "Application #{n}" }
    redirect_uri { "urn:ietf:wg:oauth:2.0:oob" }
  end
end
