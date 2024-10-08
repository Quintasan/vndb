lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "vndb/constants"

Gem::Specification.new do |spec|
  spec.name          = "vndb"
  spec.version       = Vndb::Constants::VERSION
  spec.authors       = ["Michał Zając"]
  spec.email         = ["michal.zajac@gmail.com"]

  spec.summary       = ''
  spec.description   = ''
  spec.homepage      = "https://michalzajac.me"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://michalzajac.me"
  spec.metadata["changelog_uri"] = "https://michalzajac.me"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "sorbet-runtime"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "spy"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "relaxed-rubocop"
  spec.add_development_dependency "sorbet"
end
