# include emu modules
require "emu/errors"
require "emu/api"
require "emu/oauth2"

require "emu/http_service"
require "emu/configuration"
require "emu/version"

module Emu
  # A Ruby client library for Brightcove CMS API.

  class << self
    def configure
      yield config
    end

    # Allows you to control various Emu configuration options.
    # See Emu::Configuration
    def config
      @config ||= Configuration.new
    end

    def redis
      raise ArgumentError, "requires a block" unless block_given?
      config.redis.with do |conn|
        yield conn
      end
    end

    def api_path
      config.api_path
    end
  end

  def self.make_request(url, args, verb, options = {})
    HTTPService.make_request(HTTPService::Request.new(url: url, args: args, verb: verb, options: options))
  end
end
