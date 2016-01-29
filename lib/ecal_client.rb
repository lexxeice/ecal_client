require "ecal_client/version"
require "ecal_client/api"
require "ecal_client/api/response"
require "ecal_client/api/base"
require "ecal_client/api/rest"

module EcalClient
  class Configuration
    attr_accessor :key, :secret, :options

    def initialize
      self.key     = nil
      self.secret  = nil
      self.options = {}
      set_defaults
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
