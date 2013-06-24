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
  # An Item Note in the OLE Library System Item Editor
  class Item_Note < OLE_QA::OLELS::Line_Object
    # Set screen elements for an OLELS Item Note.
    def set_elements
      element(:note_type_selector)                    {b.select_list(:id => "OleItemNoteTypeField_line#{@line_id}_control")}
      element(:note_field)                            {b.text_field(:id => "OleItemNoteDescField_line#{@line_id}_control")}
      element(:add_button)                            {b.button(:id => "OleItemNote_addTagButton_line#{@line_id}")}
      element(:remove_button)                         {b.button(:id => "OleItemNote_removeTagButton_line#{@line_id}")}
    end
  end
end