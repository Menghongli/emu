module Emu
  module HTTPService
    class Request
      attr_reader :url, :args, :verb, :options

      def initialize(params)
        @url = params[:url]
        @verb = params[:verb]
        @args = params[:args] || {}
        @options = params[:options] || {}
      end
    end
  end
end
