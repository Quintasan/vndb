require "spec_helper"

describe Vndb::Command do
  before do
    @command = Vndb::Command.new(command: "test")
  end

  describe ".new" do
    it "can be created" do
      command = Vndb::Command.new(command: "test")
      _(command).wont_be_nil
    end
  end

  describe "to_s" do
    it "seralizes to a String" do
      _(@command.to_s).must_equal("test \x04")
    end
  end
end
