class Failure
  attr_reader :code, :message

  def initialize(code, message)
    @code = code
    @message = message
  end

  def call(&block)
    yield(code, message)
  end
end