module Api
  class ApiService
    include SerializationHelper
    attr_reader :user, :params

    def self.call(user, params = nil, &block)
      new(user, params).call(&block)
    end

    def initialize(user, params)
      @user = user
      @params = params
    end

    def register_error(message, code)
      @errors = [] if @errors.nil?
      @errors << { code: code, message: message }
      nil
    end

    private_class_method :new

    def call(&block)
      raise NotImplementedError
    end

  end
end