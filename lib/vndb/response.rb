# typed: strict
module Vndb
  class Response
    extend T::Sig

    RESPONSE_REGEXP = T.let(/(^\w*)\s*({.*})*.*/xi.freeze, Regexp)

    sig { returns(String) }
    attr_reader :raw_body

    sig { returns(T.nilable(String)) }
    attr_reader :command

    sig { returns(T.nilable(String)) }
    attr_reader :body

    sig { params(raw_body: String).void }
    def initialize(raw_body:)
      @raw_body = T.let(raw_body, String)
      parsed_body = T.let(
        raw_body
          &.delete(Vndb::Constants::EOT)
          &.then { |raw_body_without_eot| RESPONSE_REGEXP.match(raw_body_without_eot) }
          &.then { |match_data| match_data.captures },
        T::Array[String]
      )
      @command = T.let(parsed_body.first, T.nilable(String))
      @body = T.let(parsed_body.last, T.nilable(String))
    end

    sig { returns(T::Boolean) }
    def success?
      !failure?
    end

    sig { returns(T::Boolean) }
    def failure?
      @raw_body.match?(/^error*/)
    end
  end
end
