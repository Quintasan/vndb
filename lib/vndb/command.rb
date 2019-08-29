module Vndb
  class Command
    attr_accessor :command, :payload

    def initialize(command:, payload: nil)
      @command = command
      @payload = payload
    end

    def to_s
      "#{@command} #{payload ? payload.to_json : ''}#{Vndb::Constants::EOT}"
    end
  end
end
