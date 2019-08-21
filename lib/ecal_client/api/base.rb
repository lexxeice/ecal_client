require 'faraday'
require 'digest/md5'
require 'uri'
require 'json'

module EcalClient
  class Api::Base
    API_ENDPOINT = "http://api.ecal.com".freeze

    protected

    def connection
      @connection ||= Faraday.new(url: API_ENDPOINT) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger if EcalClient.configuration.options[:verbose]
        faraday.adapter  Faraday.default_adapter
      end
    end

    def headers
      header_json
    end

    def api_sign(parameters = {}, body = nil)
      sorted_keys = parameters.keys.sort
      string = @secret.dup
      string << sorted_keys.inject("") { |memo, key| memo << "#{key}#{parameters[key]}" }
      string << body.to_json if body
      Digest::MD5.hexdigest(string)
    end

    def generate_params(params, body)
      params.merge(apiSign: api_sign(params, body))
    end

    [:post, :get, :put].each do |method|
      define_method "#{method}_call" do |action, params, body, headers|
        params.merge!(apiKey: @key)
        connection.send("#{method}") do |req|
          req.url action, generate_params(params, body)
          req.body = body.to_json if body
          req.headers = headers
        end
      end
    end

    def logging(msg)
      puts "[ECAL-CLIENT] #{msg}" if EcalClient.configuration.options[:verbose]
    end

    private

    def header_json
      {
        'User-Agent'        => 'Ecal Client SDK',
        'Content-Type'      => 'application/json'
      }
    end
  end
end
