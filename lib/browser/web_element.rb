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
  # A Web Element to be handled by the Selenium WebDriver
  class Web_Element

    # Selenium WebDriver Session
    attr_accessor :browser

    # Method by which the web element is retrieved.
    #   e.g. :xpath, :css, :id, etc.
    attr_accessor :how

    # Locator or identifier for the web element.
    #  e.g., "documentOverview.descriptionField"
    attr_accessor :what

    def initialize(browser, how, what)
      @browser, @how, @what = browser, how, what
    end

    # Return the Selenium WebDriver Element itself.
    # - This method will trigger the retrieval of the element.
    # - This method must be used to instantiate the element itself.
    def element
      @browser.find_element(how, what)
    end

    # Use Selenium WebDriver's .click method.
    def click
      element.click
    end

    # Return the text value of an element, if any.
    # If not, return nil.
    def text
      element.text
    end

    # Instantiate the element and say whether it is present.
    # - If successful, return true.
    # - If unsuccessful, return false.
    def present?
      element
      true
    rescue
      Selenium::WebDriver::Error::NoSuchElementError
      false
    end

    # Instantiate the element and say whether it is enabled.
    # - If the element is both displayed and enabled, return true.
    # - If the element is not displayed, return false.
    # - If the element is not enabled, return false.
    # - If the element is not present, return false.
    def enabled?
      if element.displayed? && element.enabled? then
        true
      else
        false
      end
    rescue
      Selenium::WebDriver::Error::NoSuchElementError
      false
    end

    # Instantiate the element and say whether it is selected.
    # - If the element is selected, return true.
    # - If the element is unselected, return false.
    # - If the element is not found, return false.
    def selected?
      element.selected?
    rescue
      Selenium::WebDriver::Error::NoSuchElementError
      false
    end

    # Pause until the element can be instantiated successfully.
    # If the wait_period (in seconds) is exceeded, this method
    # will return an unrescued Selenium::WebDriver error.
    def wait_til_present(wait_period)
      wait_for_it = Selenium::WebDriver::Wait.new(:timeout => wait_period)
      wait_for_it.until{ present? }
    end

    # Pause until the element is enabled (.enabled? => true).
    # If the wait_period (in seconds) is exceeded, this method
    # will return an unrescued Selenium::WebDriver error.
    def wait_til_enabled(wait_period)
      wait_for_it = Selenium::WebDriver::Wait.new(:timeout => wait_period)
      wait_for_it.until{ enabled? }
    end

    # Pause until the element is no longer enabled (.enabled? => false).
    # If the wait_period in seconds is exceeded or the element is
    # not present to begin with, this method will return an unrescued
    # Selenium::WebDriver error.
    def wait_til_disabled(wait_period)
      wait_for_it = Selenium::WebDriver::Wait.new(:timeout => wait_period)
      wait_for_it.until{ !enabled? }
    end

  end
end