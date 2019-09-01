# typed: false
require "spec_helper"

describe Vndb::Constants do
  describe Vndb::Constants::VERSION do
    it "must respond with a String" do
      _(Vndb::Constants::VERSION).must_be_instance_of String
    end

    it "must be compatible with SemVer 2.0" do
      require "support/semver_regexp"
      _(Vndb::Constants::VERSION.match?(Vndb::Spec::Support::SEMVER_REGEXP)).must_be(:==, true)
    end

    it "must be frozen" do
      _(Vndb::Constants::VERSION.frozen?).must_be(:==, true)
    end
  end

  describe Vndb::Constants::URL do
    it "must be frozen" do
      _(Vndb::Constants::URL.frozen?).must_be(:==, true)
    end
  end

  describe Vndb::Constants::EOT do
    it "must be frozen" do
      _(Vndb::Constants::EOT.frozen?).must_be(:==, true)
    end
  end
end
