class Games::GameBlueprint < BaseBlueprint
  identifier :uuid

  association :player_1, blueprint: Users::UserBlueprint, view: :normal
  association :player_2, blueprint: Users::UserBlueprint, view: :normal
end