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

module OLE_QA::OLEFS
  # A new Invoice Notes Line on an OLE Financial System Payment Request Line.
  class New_Invoice_Notes_Line < OLE_QA::Subline_Object
    # Initialize as a subclass of {OLE_QA::Subline_Object} with a subline_number of 0.
    def initialize(ole_session, line_number, which)
      super(ole_session, line_number, 0)
    end

    # Set elements on a New Invoice Notes Line object.
    # @note {OLE_QA::Line_Object} @line_number and @line_id will be used to
    #   perform substitutions in identifiers.
    # @note {OLE_QA::Subline_Object} @line_number and @line_id will not be
    #   need in finding element IDs, as there will only ever be one new
    #   subline object on each line object.
    def set_elements
      super
      element(:note_field)                              {b.text_field(:id => "document.item[#{@line_number}].note")}
      element(:add_button)                              {b.input(:name => "methodToCall.addNote.line#{@line_number}")}
    end
  end
end