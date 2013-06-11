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

module OLE_QAF

  # Load open-uri for DocStore Page Parsing
  require 'open-uri'
  require 'yaml'
  require 'version'
  require 'headless'
  require 'selenium-webdriver'

  # Add absolute directory to $LOAD_PATH
  @libdir = File.expand_path(File.dirname(__FILE__))
  $LOAD_PATH.unshift(@libdir) unless $LOAD_PATH.include?(@libdir)


  # Maintain VERSION constant on this module
  # (Handled by Version Gem)
  is_versioned

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

  # Load all independent modules
  load_libs("/module/")

  # Require all files in browser/
  load_libs('/browser/')

  # Load specific web element subtypes in order of dependency
  web_element_dir = '/browser/web_element/'
  load_libs(web_element_dir, 'data_element.rb')
  load_libs(web_element_dir, 'input_element.rb')
  load_libs(web_element_dir, 'selector_element.rb')
  load_libs(web_element_dir, 'checkbox_element.rb')

  # Load all subdirectory main files
  # (sets up definitions for base pages and objects
  # in each functional area)
  load_libs("/common/")
  load_libs("/olefs/")
  load_libs("/olels/")
  load_libs("/docstore/")

  # Load subdirectories for OLE components
  # (loads pages)
  load_libs("/common/*/")
  load_libs("/olels/*/")
  load_libs("/olefs/*/")
  load_libs("/docstore/*/")

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
    attr_accessor :base_url

    # OLE Library System Base URL
    attr_accessor :ls_url

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
    attr_accessor :options

    def initialize( options={} )
      yaml_configuration = File.open(OLE_QAF::load_dir + '/config/default_options.yml', 'r')
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
      if @options.has_key?(:browser) && @options[:browser].class == Selenium::WebDriver::Driver
        @browser = @options[:browser]
      else
        @browser = Selenium::WebDriver.for :firefox
        @browser.manage.timeouts.implicit_wait = @options[:implicit_wait]
      end

    end

    # Access Selenium WebDriver browser session.
    def browser
      @browser
    end

    # Teardown the OLE QA Framework.
    # - Exit the Selenium WebDriver browser session.
    # - Exit the Headless (XVFB) session if necessary.
    def quit
      @browser.quit
      if @options[:headless?] then
        @headless.destroy
      end
      exit
    end

    # Select a Selenium WebDriver window by its array position.
    # - 0 is base window (Selenium IDE - window=null)
    # - -1 is last opened window (used for popups)
    def select_window(array_position=0)
      @browser.switch_to.window(@browser.window_handles[array_position])
    end

  end
end
