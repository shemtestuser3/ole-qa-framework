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
  # A set of multiple Web Elements to be handled by the Selenium WebDriver
  class Web_Element_Array

    # Selenium WebDriver Session
    attr_accessor :browser

    # Method by which the web element is retrieved.
    #   e.g. :xpath, :css, :id, etc.
    attr_accessor :how

    # Locator or identifier for the set of web elements.
    #   e.g., "table#result > tbody > tr > td"
    attr_accessor :what

    def initialize(browser, how, what)
      @browser, @how, @what = browser, how, what
    end

    # Return the array of Selenium WebDriver Elements.
    # - This method will trigger the retrieval of the elements.
    # - This method must be used to instantiate the elements themselves.
    def array
      @browser.find_elements(how, what)
    end

    # Check web elements array for text values which match the given pattern.
    #
    # pattern = /regex/
    #
    # @raise StandardError unless given a regular expression.
    def match_text(pattern)
      raise StandardError, "#{pattern} is not a regular expression." unless pattern.class == Regexp
      match_results = Array.new
      array.each do |element|
          match_results << element unless element.text.scan(pattern).empty?
      end
      match_results
    end

    # Check web elements array for value attributes which match the given pattern.
    #
    # pattern = /regex/
    #
    # @raise StandardError unless given a regular expression.
    #
    def match_value(pattern)
      raise StandardError, "#{pattern} is not a regular expression." unless pattern.class == Regexp
      match_results = Array.new
      array.each do |element|
        match_results << element unless element.attribute("value").scan(pattern).empty?
      end
      match_results
    end

  end
end