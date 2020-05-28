class Games::GameBlueprint < BaseBlueprint
  identifier :id
  fields :uuid

  association :player_1, blueprint: ::Users::UserBlueprint, view: :normal
  association :player_2, blueprint: ::Users::UserBlueprint, view: :normal
  association :winner, blueprint: ::Users::UserBlueprint, view: :normal
  association :loser, blueprint: ::Users::UserBlueprint, view: :normal
  association :boards, blueprint: Games::Boards::BoardBlueprint
end