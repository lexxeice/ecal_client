module EcalClient
  class Api::Organisation < Api::Base

    ENDPOINT = "/apiv2/organisation/".freeze

    def get(options = {})
      id = options.delete(:id)
      endpoint = ENDPOINT
      endpoint += id.to_s if id
      response = get_call(endpoint, options, nil, headers)
      Response.new(response)
    end

    def post(body)
      response = post_call(ENDPOINT, {}, body, headers)
      Response.new(response)
    end

    def put(body)
      response = put_call(ENDPOINT, {}, body, headers)
      Response.new(response)
    end
  end
end
