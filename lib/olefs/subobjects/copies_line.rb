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
  # A Copies Line in an OLE Financial System PURAP E-Document.
  class Copies_Line < OLE_QA::Subline_Object
    # Set copies line elements.
    def set_elements
      super
      element(:location_copies_selector)        {b.select_list(:id => "document.item[#{@line_id}].copies[#{@subline_id}].location_copies")}
      element(:delete_button)                   {b.input(:name => "methodToCall.deleteCopy.line#{@line_id}:#{@subline_id}")}
      # Readonly Elements
      # Use these for closed, uneditable fields as on a purchase order.
      element(:closed_copies_field)             {b.div(:xpath => "//tr[td[@class='subhead'][contains(text(),'Copies #{@subline_num}')]]/following-sibling::tr[1]/td[1]/div")}
      element(:closed_location_copies_field)    {b.div(:xpath => "//tr[td[@class='subhead'][contains(text(),'Copies #{@subline_num}')]]/following-sibling::tr[1]/td[2]/div")}
      element(:closed_parts_field)              {b.div(:xpath => "//tr[td[@class='subhead'][contains(text(),'Copies #{@subline_num}')]]/following-sibling::tr[1]/td[3]/div")}
      element(:closed_part_enumeration_field)   {b.div(:xpath => "//tr[td[@class='subhead'][contains(text(),'Copies #{@subline_num}')]]/following-sibling::tr[1]/td[4]/div")}
      element(:closed_starting_copy_field)      {b.div(:xpath => "//tr[td[@class='subhead'][contains(text(),'Copies #{@subline_num}')]]/following-sibling::tr[1]/td[5]/div")}
    end
  end
end