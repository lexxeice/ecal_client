module EcalClient
  class Api
    def organisation
      @organisation ||= Organisation.new
    end
  end
end
