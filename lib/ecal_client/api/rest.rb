module EcalClient
  class Api::Rest < Api::Base

    class Unsupported < StandardError; end

    def initialize(endpoint, actions, options = {})
      @endpoint = endpoint
      @actions = actions
      @key = options[:key]
      @secret = options[:secret]
    end

    def get(options = {})
      raise Unsupported unless supported?(:get)
      id = options.delete(:id)
      endpoint = @endpoint
      endpoint += id.to_s if id
      response = get_call(endpoint, options, nil, headers)
      Response.new(response)
    end

    def post(options)
      raise Unsupported unless supported?(:post)
      response = post_call(@endpoint, {}, options, headers)
      Response.new(response)
    end

    def put(options)
      raise Unsupported unless supported?(:put)
      id = options.delete(:id)
      endpoint = @endpoint
      endpoint += id.to_s if id
      response = put_call(endpoint, {}, options, headers)
      Response.new(response)
    end

    def delete(options)
      raise Unsupported unless supported?(:delete)
      response = delete_call(@endpoint, {}, options, headers)
      Response.new(response)
    end

    private

    def supported?(action)
      @actions.include? action.to_sym
    end

  end
end
