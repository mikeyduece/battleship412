module SerializationHelper
  def serialized_resource(resource, blueprint, options)
    JSON.parse(blueprint.render(resource, options), symbolize_names: true)
  end

  def success_response(data = {}, message = nil, status = 200)
    response = default_response(status, message, data)
    render json: response
  end

  def error_response(message, status = 404)
    response = default_response(status, message)
    render json: response
  end

  def default_response(status, message, data = nil)
    {status: status, message: message}.merge(data)
  end
end