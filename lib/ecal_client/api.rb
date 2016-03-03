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
      @options = options
    end

    def organisation
      @organisation ||= Rest.new(endpoint_for(ORGANISATION), [:get, :post, :put], @options)
    end

    def publisher
      @publisher ||= Rest.new(endpoint_for(PUBLISHER), [:get, :put], @options)
    end

    def calendar
      @calendar ||= Rest.new(endpoint_for(CALENDAR), [:get, :post, :put], @options)
    end

    def event
      @event ||= Rest.new(endpoint_for(EVENT), [:get, :post, :put], @options)
    end

    def subscription_widget
      @subscription_widget ||= Rest.new(endpoint_for(SUBSCRIPTION_WIDGET), [:get], @options)
    end

    def subscriber
      @subscriber ||= Rest.new(endpoint_for(SUBSCRIBER), [:get, :post, :put], @options)
    end

    private

    def endpoint_for(name)
      API_VERSION + name
    end
  end
end
