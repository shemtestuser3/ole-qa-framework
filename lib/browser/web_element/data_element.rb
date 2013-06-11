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
  # A Web Element which contains useful data.
  class Data_Element < Web_Element

    # Return the value of a given web element, assuming it has one.
    def value
      element.attribute("value")
    end

    # Verify that the value of a given web element is the same as the string given.
    # - Uses equivalence, not pattern matching.
    # - Returns true if the value is the same.
    # - Returns false if the value is not the same.
    # - Returns false if the element is not found.
    #
    # what = "Text Value"
    #
    def verify_value(what)
      (value == what) ? true : false
    rescue
      Selenium::WebDriver::Error::NoSuchElementError
      false
    end

    # Verify that the text of a given web element is the same as the string given.
    # - Uses equivalence, not pattern matching.
    # - Returns true if the text is the same.
    # - Returns true if the text minus whitespace wrapping is the same.
    # - Returns false if the text is not the same.
    # - Returns false if the element is not found.
    #
    # what = "Text"
    #
    def verify_text(what)
      (text == what || text.strip == what) ? true : false
    rescue
      Selenium::WebDriver::Error::NoSuchElementError
      false
    end

  end
end