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
  # A Notes Line in an OLE Financial System PURAP E-Document.
  class Notes_Line < OLE_QA::Subline_Object
    # Set notes line elements.
    def set_elements
      super
      element(:note_type_selector)            {b.select_list(:id => "document.item[#{@line_id}].notes[#{@subline_id}].noteTypeId")}
      element(:note_field)                    {b.text_field(:id => "document.item[#{@line_id}].notes[#{@subline_id}].note")}
      element(:delete_button)                 {b.input(:name => "methodToCall.deleteNote.line#{@line_id}:#{@subline_id}")}
      # Use the elements below for a closed, inaccessible notes field on a PURAP document like a Purchase Order.
      element(:closed_note_type_field)        {b.td(:xpath => "//tr[starts-with(@id,'tab-Notes')]/th/table[@class = 'datatable']/tbody[1]/tr[td[@class = 'subhead'][contains(text(),'Note #{@subline_num}')]]/following-sibling::tr[1]/td[1]")}
      element(:closed_note_field)             {b.td(:xpath => "//tr[starts-with(@id,'tab-Notes')]/th/table[@class = 'datatable']/tbody[1]/tr[td[@class = 'subhead'][contains(text(),'Note #{@subline_num}')]]/following-sibling::tr[1]/td[2]")}
    end
  end
end