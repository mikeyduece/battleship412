FactoryBot.define do
  factory :game do
    uuid { "MyString" }
    association :player_1, factory: :user
    association :player_2, factory: :user
  end
end
