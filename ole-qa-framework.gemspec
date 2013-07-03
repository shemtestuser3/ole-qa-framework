# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ole_qa_framework/VERSION"

Gem::Specification.new do |spec|
  spec.name          = "ole-qa-framework"
  spec.version       = OLE_QA::Framework::VERSION
  spec.authors       = ["Jain Waldrip"]
  spec.email         = ["jkwaldri@indiana.edu"]
  spec.description   = "Watir-Webdriver Based Page-Object Framework for Kuali Open Library Environment QA Testing"
  spec.summary       = "Kuali Open Library Environment"
  spec.homepage      = "http://www.github.com/jkwaldrip/ole-qa-framework/"
  spec.license       = "ECLv2"

  spec.files         = Dir.glob("**/**/**")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '~> 1.9.3'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "yard"

  spec.add_dependency "watir-webdriver"
  spec.add_dependency "headless"
  spec.add_dependency "rspec"
end
