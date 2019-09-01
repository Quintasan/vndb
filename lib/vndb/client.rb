# typed: true
require 'vndb/command'
require 'vndb/response'
require 'pry-byebug'
require 'socket'
require 'json'

module Vndb
  class Client
    extend T::Sig

    sig { returns(T.nilable(IO)) }
    attr_reader :socket

    sig { params(username: T.nilable(String), password: T.nilable(String)).void }
    def initialize(username: nil, password: nil)
      @username = T.let(username, T.nilable(String))
      @password = T.let(password, T.nilable(String))

      @socket = T.let(TCPSocket.open(Vndb::Constants::URL, Vndb::Constants::PORT), T.nilable(IO))
      payload = T.let({
                        protocol: 1,
                        client: "vndb-ruby",
                        clientver: Vndb::Constants::VERSION
                      }, Hash)
      payload = merge_credentials(payload, @username, @password) if @username && @password
      command = Vndb::Command.new(command: "login", payload: payload)
      @socket.puts(command.to_s)
      data = T.must(@socket).recv(1024)
      response = Vndb::Response.new(raw_body: T.must(data))
      raise(Vndb::Error, T.must(response.body)) unless response.success?
    end

    sig { returns(Hash) }
    def dbstats
      command = Vndb::Command.new(command: "dbstats")
      @socket.puts(command.to_s)
      data = T.must(@socket).recv(1024)
      Vndb::Response.new(raw_body: T.must(data))
                    .then { |response| JSON.parse(response.body) }
    end

    private

    sig { params(payload: Hash, username: String, password: String).returns(Hash) }
    def merge_credentials(payload, username, password)
      payload.merge(
        username: username,
        password: password
      )
    end
  end
end
