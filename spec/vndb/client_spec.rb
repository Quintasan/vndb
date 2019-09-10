# typed: false
require "spec_helper"

describe Vndb::Client do
  describe ".new" do
    it "can be created" do
      login_string = "login {\"protocol\":1,\"client\":\"vndb-ruby\",\"clientver\":\"0.1.0\"}\u0004"

      command_mock = Minitest::Mock.new
      command_mock.expect(:to_s, login_string)
      command_spy = Spy.on(Vndb::Command, :new).and_return(command_mock)

      socket_mock = Minitest::Mock.new
      socket_mock.expect(:puts, nil, [login_string])
      socket_mock.expect(:read, "ok\x04", [1024])
      socket_mock.expect(:is_a?, "ok\x04", [IO])
      socket_spy = Spy.on(TCPSocket, :open).and_return(socket_mock)

      response_mock = Minitest::Mock.new
      response_mock.expect(:success?, true)
      response_spy = Spy.on(Vndb::Response, :new).and_return(response_mock)

      Vndb::Client.new

      assert command_spy.has_been_called?
      assert socket_spy.has_been_called?
      assert response_spy.has_been_called?
      command_mock.verify
      socket_mock.verify
      response_mock.verify
    end
  end

  describe ".dbstats" do
    it "returns database statistics" do
      dbstats_string = "dbstats\x04"

      client_mock = Minitest::Mock.new
      client_mock.expect(:dbstats, dbstats_string)
      client_spy = Spy.on(Vndb::Client, :new).and_return(client_mock)

      Vndb::Client.new.dbstats

      client_spy.has_been_called?
      client_mock.verify
    end
  end
end
