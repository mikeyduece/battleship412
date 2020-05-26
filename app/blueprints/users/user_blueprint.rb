class Users::UserBlueprint < BaseBlueprint
  identifier :id

  view :normal do
    fields :first_name, :last_name
  end

  view :extended do
    fields :first_name, :last_name, :email
  end
end