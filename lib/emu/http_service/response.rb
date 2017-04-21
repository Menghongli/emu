module Emu
  module HTTPService
    class Response
      attr_reader :status, :body, :headers

      def initialize(status, body, headers)
        @status = status
        @body = body
        @headers = headers
      end
    end
  end
end

