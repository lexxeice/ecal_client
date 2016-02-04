module EcalClient
  class Response

    def initialize(response)
      @response = response
    end

    def success?
      [ 200 ].include? status
    end

    def status
      @response.status.to_i
    end

    def status_long
      @status_log ||= params['statusLong']
    end

    def errors
      @error ||= params['errors']
    end

    def params
      @params ||= begin
                    JSON.parse(@response.body)
                  rescue => e
                    puts e.to_s if EcalClient.configuration.options[:verbose]
                  end
      @params ||= {}
    end
  end
end
