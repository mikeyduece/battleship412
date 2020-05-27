FactoryBot.define do
  factory :board do
    board_type { 0 }
    association :game, factory: :game
    association :player, factory: :user
  end
end
