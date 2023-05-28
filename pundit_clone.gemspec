# frozen_string_literal: true

require_relative "lib/pundit_clone/version"

Gem::Specification.new do |spec|
  spec.name = "pundit_clone"
  spec.version = PunditClone::VERSION
  spec.authors = ["Alexandre Ruban"]
  spec.email = ["alexandre@hey.com"]

  spec.summary = "Pundit clone"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.files = Dir["lib/**/*.rb", "MIT-LICENSE", "README.md"]

  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
end
