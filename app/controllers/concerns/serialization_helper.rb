module SerializationHelper
  def success_response(status = 200, data = {}, message = nil)
    default_response = default_response(status, message, data)
    render json: default_response
  end

  def error_response(message, status = 404)
    default_response = default_response(status, message)
    render json: default_response
  end

  def default_response(status, message, data = nil)
    {status: status, message: message}.merge(data)
  end
end