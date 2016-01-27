require "ecal_client/version"

module EcalClient
  class Configuration
    attr_accessor :key, :secret

    def initialize
      self.key     = nil
      self.secret  = nil
      self.options = {}
      set_default
    end

    def set_defaults
      options[:verbose] ||= false
      options[:read_timeout] ||= 30
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end
end
