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

module OLE_QA::Framework::OLEFS
  # A new Exception Notes Line on an OLE Financial System Receiving Line.
  class New_Exception_Notes_Line < OLE_QA::Framework::Subline_Object
    # Initialize as a subclass of {OLE_QA::Framework::Subline_Object} with a subline_number of 0.
    def initialize(ole_session, line_number, which)
      super(ole_session, line_number, 0)
    end

    # Set elements on a New Exception Notes Line.
    def set_elements
      element(:exception_type_selector)               {b.select_list(:id => "document.item[#{@line_id}].exceptionTypeId")}
      element(:note_field)                            {b.text_field(:id => "document.item[#{@line_id}].exceptionNotes")}
      element(:note_type_selector)                    {b.select_list(:id => "document.item[#{@line_id}].exceptionTypeId")}
    end
  end
end