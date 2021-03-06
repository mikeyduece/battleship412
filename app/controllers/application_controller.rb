class ApplicationController < ActionController::API
  include SerializationHelper
  before_action :doorkeeper_authorize!

  private

  def handle_error(model)
    model.errors.full_messages.first
  end

  delegate :t, to: I18n

  def doorkeeper_unauthorized_render_options(error: nil)
    { json: { error: "Not Authorized" } }
  end

  def current_api_user
    @current_api_user ||= User.find_by(id: doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

end
