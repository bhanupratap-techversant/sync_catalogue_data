require_relative 'lib/sync_catalogue_data/version'

Gem::Specification.new do |spec|
  spec.name          = "sync_catalogue_data"
  spec.version       = SyncCatalogueData::VERSION
  spec.authors       = ["Bhanu Pratap Singh"]
  spec.email         = ["bhanupratap@techversantinfo.com"]

  spec.summary       = %q{sync_catalogue_data is the service to sync catalogue data.}
  spec.description   = %q{Import the catalogue data from government authorized sites in British Columbia.}
  spec.homepage      = "https://github.com/bhanupratap-techversant/sync_catalogue_data"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/bhanupratap-techversant/sync_catalogue_data"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir['lib/**/*.rb'] + Dir['bin/*']
  spec.files += Dir['[A-Z]*'] + Dir['spec/**/*']
  spec.files.reject! { |fn| fn.include? "CVS" }

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
