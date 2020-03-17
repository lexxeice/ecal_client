module EcalClient
  class Api

    API_VERSION         = "/apiv2".freeze
    ORGANISATION        = "/organisation/".freeze
    PUBLISHER           = "/publisher/".freeze
    CALENDAR            = "/calendar/".freeze
    EVENT               = "/event/".freeze
    SUBSCRIPTION_WIDGET = "/subscription-widget/".freeze
    SUBSCRIBER          = "/subscriber/".freeze

    def initialize(options = {})
      @key = options.delete(:key) || EcalClient.configuration.key
      @secret = options.delete(:secret) || EcalClient.configuration.secret
      EcalClient.configuration.options.merge!(options)
    end

    def credentials
      { key: @key, secret: @secret }
    end

    def organisation
      @organisation ||= Rest.new(endpoint_for(ORGANISATION), [:get, :post, :put], credentials)
    end

    def publisher
      @publisher ||= Rest.new(endpoint_for(PUBLISHER), [:get, :put], credentials)
    end

    def calendar
      @calendar ||= Rest.new(endpoint_for(CALENDAR), [:get, :post, :put, :delete], credentials)
    end

    def event
      @event ||= Rest.new(endpoint_for(EVENT), [:get, :post, :put, :delete], credentials)
    end

    def subscription_widget
      @subscription_widget ||= Rest.new(endpoint_for(SUBSCRIPTION_WIDGET), [:get], credentials)
    end

    def subscriber
      @subscriber ||= Rest.new(endpoint_for(SUBSCRIBER), [:get, :post, :put], credentials)
    end

    private

    def endpoint_for(name)
      API_VERSION + name
    end
  end
end
