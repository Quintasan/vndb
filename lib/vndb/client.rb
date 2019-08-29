require 'vndb/command'
require 'vndb/response'
require 'pry-byebug'
require 'socket'
require 'json'

module Vndb
  class Client
    attr_reader :socket

    def initialize(username: nil, password: nil)
      @username = username
      @password = password

      @socket = TCPSocket.open(Vndb::Constants::URL, Vndb::Constants::PORT)
      payload = {
        protocol: 1,
        client: "vndb-ruby",
        clientver: Vndb::Constants::VERSION
      }
      payload = merge_credentials(payload, @username, @password) if @username && @password
      command = Vndb::Command.new(command: "login", payload: payload)
      @socket.puts(command.to_s)
      data = @socket.recv(1024)
      response = Vndb::Response.new(raw_body: data)
      raise(Vndb::Error, response.body) unless response.success?
    end

    def dbstats
      command = Vndb::Command.new(command: "dbstats")
      @socket.puts(command.to_s)
      data = @socket.recv(1024)
      Vndb::Response.new(raw_body: data)
                    .then { |response| JSON.parse(response.body) }
    end

    private

    def merge_credentials(payload, username, password)
      payload.merge(
        username: username,
        password: password
      )
    end
  end
end
