require "spec_helper"

describe Vndb::Response do
  before do
    @raw_login_response = "ok\x04".freeze
    @successful_response = Vndb::Response.new(raw_body: "test")
    @unsuccessful_response = Vndb::Response.new(raw_body: "error")
  end

  describe ".new" do
    it "can be created" do
      response = Vndb::Response.new(raw_body: @raw_login_response)
      _(response).wont_be_nil
    end
  end

  describe "#failure?" do
    it "will return false when there's no error" do
      _(@successful_response.failure?).must_equal(false)
    end

    it "will return true when there is an error" do
      _(@unsuccessful_response.failure?).must_equal(true)
    end
  end

  describe "#success?" do
    it "will return true when there's no error" do
      _(@successful_response.success?).must_equal(true)
    end

    it "will return false when there is an error" do
      _(@unsuccessful_response.success?).must_equal(false)
    end
  end
end
