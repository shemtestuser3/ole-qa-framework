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

module OLE_QA::OLELS
  # An Ownership Note on an OLE Library System Extent of Ownership Line.
  class Ownership_Note < OLE_QA::Subline_Object
    # Set ownership note screen elements.
    def set_elements
      element(:note_type_selector)                  {b.select_list(:id => "extentSubHoldingNoteTypeField_line#{@line_id}_line#{@subline_id}_control")}
      element(:note_field)                          {b.text_field(:id => "extentSubHoldingNoteDescField_line#{@line_id}_line#{@subline_id}_control")}
      element(:add_button)                          {b.button(:id => "oleEowHoldingNotes_addTagButton_line#{@line_id}_line#{@subline_id}")}
      element(:remove_button)                       {b.button(:id => "oleEowHoldingNotes_removeTagButton_line#{@line_id}_line#{@subline_id}")}
    end
  end
end