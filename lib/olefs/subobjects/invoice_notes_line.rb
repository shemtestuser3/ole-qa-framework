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
  # An Invoice Notes Line on an OLE Financial System Payment Request.
  class Invoice_Notes_Line < OLE_QA::Subline_Object
    # Set invoice notes line elements.
    def set_elements
      super
      element(:note_field)                {b.text_area(:id => "document.item[#{@line_id}].notes[#{@subline_id}].note")}
      element(:delete_button)             {b.input(:xpath => "//input[@name='methodToCall.deleteNote.line#{@line_id}:#{@subline_id}']")}
    end
  end
end