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

module OLE_QA::Framework
  # OLE object class to be inherited by both Page Object and Data Object classes.
  #   (Grouping together common initialize settings for DRYness.)
  # @note The instance variable @browser can be used internally to refer to the
  #   browser and only the browser, whereas the instance method .browser, defined
  #   in {OLE_QA::Framework::Helpers#browser} will refer either to the browser
  #   itself or to the browser within the context of the "iframeportlet" frame,
  #   if it is found to be present.
  class Common_Object
    include OLE_QA::Framework::Helpers

    # The OLE_QA::Framework::Session instance passed to the Data Object.
    attr_accessor :ole

    # Arrays containing the names(Symbol) of each element or function declared
    #   on a data object.
    attr_reader :elements, :functions

    # @param ole_session [Object] The OLE_QA::Framework::Session instance with which the object should load.
    def initialize(ole_session)
      @ole = ole_session
      @browser = ole_session.browser
      @elements = Array.new
      @functions = Array.new
      set_elements if defined?(self.set_elements)
      set_functions if defined?(self.set_functions)
    end

    # Fill this method with element definitions in a subclass.
    # - Call super first in this method if the subclass overrides elements from the superclass.
    # - Use with {OLE_QA::Framework::Helpers#set_element}
    # @note This method is automatically called on any subclass if defined therein.
    def set_elements
    end

    # Fill this method with function definitions in a subclass.
    # - Call super first in this method if the subclass overrides functions from the superclass.
    # - Use with {OLE_QA::Framework::Helpers#set_function}
    # @note This method is automatically called on any subclass if defined therein.
    def set_functions
    end
  end
end