#  Copyright 2005-2013 The Kuali Foundation
#
#  Licensed under the Educational Community License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at:
#
#    http://www.opensource.org/licenses/ecl2.php
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

libdir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'rubygems'
require 'rspec/core/rake_task'
require 'lib/ole_qa_framework'

spec = Gem::Specification.new do |spec|
  spec.name = 'ole_qa_framework'
  spec.version = OLE_QAF::VERSION
  spec.summary = 'Kuali OLE Test Framework'
  spec.description = 'Provides a Page-Object Testing Framework for the Kuali Open Library Environment Testing Server'
  spec.author = "Jain Waldrip"
  spec.email = "jkwaldri@indiana.edu"
  spec.homepage = "https://github.com/jkwaldrip/OLE-QA-Framework"
  spec.license = "ECLv2"
  spec.required_ruby_version = '>= 1.9.3'
  spec.requirements = 'xvfb, X-windows Virtual Frame Buffer'
  spec.require_paths = ['lib']
  spec.files = Dir.glob("**/**/**")
  spec.autorequire = 'ole_qa_framework'
  spec.add_dependency('headless')
  spec.add_dependency('selenium-webdriver')
  spec.add_dependency('version')
  spec.add_dependency('json','~> 1.7.7')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('yard')
  spec.add_development_dependency('redcarpet')
end

namespace :test do

  desc "Run all specs"
  task :run_all do
    Dir["#{File.dirname(__FILE__)}/spec/*/*_spec.rb"].each do |spec|
      sh "rspec #{spec}"
    end
  end

  desc "Run non-OLE specs only"
  task :non_ole do
    Dir["#{File.dirname(__FILE__)}/spec/browser/*_spec.rb"].each do |spec|
      sh "rspec #{spec}"
    end
    Dir["#{File.dirname(__FILE__)}/spec/element/*_spec.rb"].each do |spec|
      sh "rspec #{spec}"
    end
    Dir["#{File.dirname(__FILE__)}/spec/test_pages/*_spec.rb"].each do |spec|
      sh "rspec #{spec}"
    end
  end

  desc "Run OLE specs only"
  task :ole_only do
    Dir["#{File.dirname(__FILE__)}/spec/olefs/*_spec.rb"].each do |spec|
      sh "rspec #{spec}"
    end
    Dir["#{File.dirname(__FILE__)}/spec/olels/*_spec.rb"].each do |spec|
      sh "rspec #{spec}"
    end
  end

  desc "Run all page specs"
  task :all_pages do
    Dir["#{File.dirname(__FILE__)}/spec/page/*_spec.rb"].each do |spec|
      sh "rspec #{spec}"
    end
    Dir["#{File.dirname(__FILE__)}/spec/olefs/*_spec.rb"].each do |spec|
      sh "rspec #{spec}"
    end
    Dir["#{File.dirname(__FILE__)}/spec/olels/*_spec.rb"].each do |spec|
      sh "rspec #{spec}"
    end
  end

end

task :default => ['version:show']