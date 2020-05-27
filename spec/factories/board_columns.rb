FactoryBot.define do
  factory :board_column do
    association :board, factory: :board
    association :column, factory: :column
    association :row, factory: :row
  end
end
