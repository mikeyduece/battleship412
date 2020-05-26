class Api::V1::Users::UsersController < ApplicationController
  skip_before_action :doorkeeper_authorize!, only: :create

  def create
    user = User.new(user_params)

    return success_response(user: ::Users::UserBlueprint, view: :extended) if user.save!
    error = handle_error(user)

    error_response(error, 404)
  end

  def destroy
    user = User.find_by(id: user_params[:id])

    return success_response(204, deleted: true) if user.destroy
    error = handle_error(user)

    error_response(error, 404)
  end

  private

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :password, :email)
  end

end