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
  # A Checkbox Web Element.
  class Checkbox_Element < Data_Element

    # Return whether or not a given checkbox element is checked.
    # - Uses Selenium's .selected? method.
    # - Returns true if the element is checked.
    # - Returns false if the element is unchecked.
    # - Returns a Selenium::WebDriver Error if the element is not found.
    #
    def checked?
      element.selected?
    end

    # Return whether or not a given checkbox element is checked.
    # - Uses Selenium's .selected? method.
    # - Returns true if the element is checked.
    # - Returns false if the element is unchecked.
    # - Returns false if the element is not found.
    #
    def verify_checked
      if checked? then
        true
      else
        false
      end
    rescue
      Selenium::WebDriver::Error::NoSuchElementError
      false
    end

    # Check an unchecked checkbox element, return a Boolean value for the result.
    #
    # - This will return true if the element is already checked.
    # - This will return true after clicking if the element was not already checked.
    # - This will return false if the element is not found.
    #
    def check
      unless element.selected? then
        element.click
        true
      else
        true
      end
    rescue Selenium::WebDriver::Error::NoSuchElementError
      false
    end

    # Uncheck a checked checkbox element, return a Boolean value for the result.
    #
    # - This will return true if the element is already unchecked.
    # - This will return true after clicking if the element was already checked.
    # - This will return false if the element is not found.
    #
    def uncheck
      if element.selected? then
        element.click
        true
      else
        true
      end
    rescue Selenium::WebDriver::Error::NoSuchElementError
      false
    end

  end

end