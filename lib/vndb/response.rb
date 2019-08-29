module Vndb
  class Response
    RESPONSE_REGEXP = /(^\w*)\s*({.*})*.*/xi.freeze
    attr_reader :raw_body, :command, :body

    def initialize(raw_body:)
      @raw_body = raw_body
      @command, @body = raw_body
        &.delete(Vndb::Constants::EOT)
        &.then { |raw_body_without_eot| RESPONSE_REGEXP.match(raw_body_without_eot) }
        &.then { |match_data| match_data.captures }
    end

    def success?
      !failure?
    end

    def failure?
      @raw_body.match?(/^error*/)
    end
  end
end
