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
  # A Receipt Notes Line in an OLE Financial System Receiving Document
  class Receipt_Notes_Line < OLE_QA::Subline_Object
    # Set receipt notes elements.
    def set_elements
      super
      element(:note_type_selector)                    {b.select_list(:id => "document.item[#{@line_id}].receiptNoteList[#{@subline_id}].noteTypeId")}
      element(:note_field)                            {b.text_field(:id => "document.item[#{@line_id}].receiptNoteList[#{@subline_id}].notes")}
    end
  end
end