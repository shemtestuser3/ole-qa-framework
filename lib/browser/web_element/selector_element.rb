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
  # A dropdown list Web Element.
  class Selector_Element < Data_Element

    # Select an option from the list.
    #
    # how - the method by which the value is designated
    #   e.g., :text
    # what - the locator or identifier for the value to be selected
    #   e.g., "Book"
    #
    # - This will instantiate the Selector Element using the .element method.
    # - This will return a Selenium::WebDriver Error if the element does not exist.
    def select_option(how, what)
      Selenium::WebDriver::Support::Select.new(element).select_by(how, what)
    end

  end
end