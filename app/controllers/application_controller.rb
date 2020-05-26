class ApplicationController < ActionController::API
  include SerializationHelper
  before_action :doorkeeper_authorize!

  private

  def handle_error(model)
    model.errors.full_messages.first
  end

end
