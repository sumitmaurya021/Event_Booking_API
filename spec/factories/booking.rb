FactoryBot.define do
  factory :booking do
    association :user, factory: :user
    association :event, factory: :event
  end
end
