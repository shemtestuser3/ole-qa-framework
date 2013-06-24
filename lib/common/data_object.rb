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

  # An object in OLE which contains screen elements but is not itself a screen element.
  class Data_Object

    include OLE_QA::Helpers
    include OLE_QA::Data_Helpers

    # The OLE_QA::Framework session passed to the Data Object.
    attr_accessor :ole

    # @param ole_session [Object] The OLE_QA::Framework session with which the data object should load.
    def initialize(ole_session)
      @ole = ole_session
      set_elements if defined?(self.set_elements)
    end

    # Fill this method with element definitions in a subclass.
    # - Call super first in this method if the subclass overrides elements from the superclass.
    # - Use with {OLE_QA::Helpers#set_element}
    # @note This method is automatically called on any subclass of Data Object which invokes the original
    #   initialize method.
    def set_elements
    end
  end
end