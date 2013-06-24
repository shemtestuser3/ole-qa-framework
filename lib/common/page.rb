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

  # An OLE Page object
  class Page

    # The OLE_QA::Framework session passed to the Page object.
    attr_accessor :ole

    # The URL to open a given page.
    # @note Do not use this value for the URL to open a new page of a given
    #   document type.  If the page object represents an e-Document in OLEFS
    #   or OLELS, instead use the :new_url accessor set on the e-Doc object.
    attr_reader :url

    include OLE_QA::Helpers
    include OLE_QA::Page_Helpers

    # @param ole_session [Object] The OLE_QA::Framework session in which the page should load.
    # @param url [String] The URL (if any) used to open the page.  (Set to "" if unused.)
    def initialize(ole_session, url)
      @ole = ole_session
      @browser = ole_session.browser
      @url = url
      @wait_on = Array.new
      set_elements if defined?(self.set_elements)
      wait_for_elements if defined?(self.wait_for_elements)
    end

    # Open the page via URL.
    # @note Some pages may not have custom open URLs.  If this is the case,
    #   this method can be passed a lookup URL with a document ID #.
    # @note This method will invoke the wait_for_elements method if it is defined on a page.
    # @note If a page has declared elements to wait on, invoking this method will return
    #   an array of the symbols used to call those methods.
    def open(url = @url)
      @browser.goto(url)
      @wait_on.each { |element| wait_for_element(element) } if defined?(wait_for_elements)
    end

    # Fill this method with element definitions in a subclass.
    # - Call super first in this method if the subclass overrides elements from the superclass.
    # - Use with {OLE_QA::Helpers#set_element}
    # @note This method is automatically called on any subclass of Page which invokes the original
    #   initialize method.
    def set_elements
    end

    # Define this method on a subclass.  Add element symbols to the @wait_on array.
    # This will require the open method to wait for each of these elements to be present before it finishes.
    #   e.g.
    #   def wait_for_elements
    #     @wait_on << :title
    #     @wait_on << :close_button
    #     super
    #   end
    #
    def wait_for_elements
    end

    # Use this method on subclasses to define elements that must be loaded for the page to be considered completely loaded.
    # This method can be called individually or will be called on an open command if .wait_for_elements is defined on the subclass.
    def wait_for_element(element)
      self.send(element).wait_until_present(@ole.explicit_wait)
    end

    # Call this method on a page that has wait_for_elements defined
    # to wait for all required elements on that page to load.
    def wait_for_page_to_load
      @wait_on.each { |element| wait_for_element(element) }
    end

  end
end