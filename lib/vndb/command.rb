# typed: true
module Vndb
  class Command
    extend T::Sig

    attr_accessor :command, :payload

    sig { params(command: String, payload: T.nilable(Hash)).void }
    def initialize(command:, payload: nil)
      @command = T.let(command, String)
      @payload = T.let(payload, T.nilable(Hash))
    end

    sig { returns(String) }
    def to_s
      "#{@command} #{payload ? payload.to_json : ''}#{Vndb::Constants::EOT}"
    end
  end
end
