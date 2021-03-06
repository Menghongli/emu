require 'oauth2'

module Emu
  module OAuth2
    class << self
      # get access token from Redis if exists
      # otherwise generate a new token and set it to redis
      def get_token
        token = nil
        Emu.redis do |conn|
          token = conn.get(token_key)
        end
        if token.nil? || token.empty?
          token = set_token
        end
        token
      end

      def set_token
        client = ::OAuth2::Client.new(Emu.config.client_id, Emu.config.client_secret,
                                    site: Emu.config.site,
                                    token_url: Emu.config.token_url)
        access_token = client.client_credentials.get_token

        Emu.redis do |conn|
          conn.set(token_key, access_token.token)
          conn.expire(token_key, access_token.expires_in)
        end
        access_token.token
      end

      def token_key
        [Emu.config.redis_prefix, "brightcove", "access_token"].join(':')
      end
    end
  end
end
