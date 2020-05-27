FactoryBot.define do
  factory :board do
    board_type { 1 }
    association :game, factory: :game
    association :player, factory: :user
  end
end
