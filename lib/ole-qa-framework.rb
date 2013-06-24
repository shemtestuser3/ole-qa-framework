#!/usr/bin/env ruby

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

module OLE_QA

  # Load open-uri for DocStore Page Parsing
  require 'open-uri'
  require 'yaml'
  require 'headless'
  require 'watir-webdriver'

  # Add absolute directory to $LOAD_PATH
  @libdir = File.expand_path(File.dirname(__FILE__))
  $LOAD_PATH.unshift(@libdir) unless $LOAD_PATH.include?(@libdir)

  # Return absolute path from which the file was run
  def self.load_dir
    @libdir
  end

  # Load libraries from absolute path
  def self.load_libs(filedir, filename = "*.rb")
    Dir[@libdir + filedir + filename].sort.each do |file|
      require file
    end
  end

  # Load main class libraries
  load_libs("/ole_qa_framework/")

  # Load all independent modules
  load_libs("/module/")

  # Load Page & Element Definitions.
  # Main directory is loaded first, then subdirectories in alphabetical order.
  # If pages or elements need to be inherited by subclasses, put them in a (foo)/common/ directory.
  # Subobject directories (foo)/subobjects/ should be loaded before object directories (foo)/objects/ for inheritance.
  load_libs("/common/")
  # load_libs("/olefs/")
  load_libs("/olefs/common/")
  load_libs("/olefs/subobjects/")
  load_libs("/olefs/objects/")
  load_libs("/olefs/pages/")
  load_libs("/olels/common/")
  load_libs("/olels/subobjects/")
  load_libs("/olels/objects/")
  load_libs("/olels/pages/")
  # load_libs("/docstore/")

  # Handle Browser Functions, Headless Session
  #   Invoke with @ole = Framework.new(opts)
  #   Exit with @ole.quit
  #
  # Default options loaded from
  #   lib/config/default_options.yml
  #
  class Framework

    # OLE Installation Base URL
    # - Also serves as OLE Financial System Main Menu URL
    attr_reader :base_url
    alias :fs_url :base_url

    # OLE Library System Base URL
    attr_reader :ls_url

    # Wait period (in seconds) used by OLE QAF Web Element functions
    attr_accessor :explicit_wait

    # Options hash keys:
    #   :base_url => "http://tst.ole.kuali.org/"
    #     (URL for OLE Installation)
    #   :ls_url => "http://tst.rice2.ole.kuali.org"
    #     (URL for OLE Library System Rice Instance)
    #   :headless => true/false
    #     (Use Headless gem to handle XVFB session)
    #   :implicit_wait => NN
    #     (Set Selenium Webdriver's default wait period)
    #   :explicit_wait => NN
    #     (Set the wait period used by custom wait functions)
    #   :doc_route_wait => NN
    #     (Set the wait period for eDoc routing to complete)
    #   :browser => selenium_webdriver
    #     (Where browser is a Selenium WebDriver session)
    #
    # To configure the default options, edit
    #   lib/config/default_options.yml
    #
    attr_reader :options

    def initialize( options={} )
      yaml_configuration = File.open(OLE_QA::load_dir + '/config/default_options.yml', 'r')
      options_defaults = YAML.load(yaml_configuration)
      yaml_configuration.close
      @options = options_defaults.merge(options)

      # Start headless session if requested
      if @options[:headless?] then
        @headless = Headless.new
        @headless.start
      end

      # Globalize options to accessors
      @base_url = @options[:base_url]
      @ls_url = @options[:ls_url]
      @explicit_wait = @options[:explicit_wait]
      @page_route_wait = @options[:page_route_wait]

      # Browser Start
      if @options.has_key?(:browser) && @options[:browser].class == Watir::Browser
        @browser = @options[:browser]
      else
        @browser = Watir::Browser.new :firefox
        @browser.driver.manage.timeouts.implicit_wait = @options[:implicit_wait]
      end

    end

    # Access Watir-Webdriver's browser session.
    def browser
      @browser
    end

    # Access Watir-Webdriver's Window Handling Method
    def windows
      @browser.windows
    end

    # Teardown the OLE QA Framework.
    # - Exit the Selenium WebDriver browser session.
    # - Exit the Headless (XVFB) session if necessary.
    def quit
      @browser.quit
      if @options[:headless?] then
        @headless.destroy
      end
    end

  end
end
