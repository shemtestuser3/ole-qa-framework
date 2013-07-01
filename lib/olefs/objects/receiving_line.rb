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
  # A single line on an OLE Financial System Receiving Document
  class Receiving_Line < OLE_QA::OLEFS::Line_Object
    # Create accessor methods for new subline objects.
    def set_sublines
      create_subline("new_exception_notes_line","New_Exception_Notes_Line")
      create_subline("new_receipt_notes_line","New_Receipt_Notes_Line")
      create_subline("new_copies_line","New_Copies_Line")
    end

    # Set receiving line elements.
    def set_elements
      super
      element(:description_field)                         {b.td(:xpath => "//table[@summary='Items Section']/tbody/tr/td[1][b[contains(text(),'#{@line_number}')]]/following-sibling::td[2]")}
      element(:quantity_ordered_field)                    {b.td(:xpath => "//table[@summary='Items Section']/tbody/tr/td[1][b[contains(text(),'#{@line_number}')]]/following-sibling::td[4]")}
      element(:parts_ordered_field)                       {b.td(:xpath => "//table[@summary='Items Section']/tbody/tr/td[1][b[contains(text(),'#{@line_number}')]]/following-sibling::td[5]")}
      element(:prior_quantity_received_field)             {b.td(:xpath => "//table[@summary='Items Section']/tbody/tr/td[1][b[contains(text(),'#{@line_number}')]]/following-sibling::td[6]")}
      element(:prior_parts_received_field)                {b.td(:xpath => "//table[@summary='Items Section']/tbody/tr/td[1][b[contains(text(),'#{@line_number}')]]/following-sibling::td[7]")}
      element(:quantity_to_be_received_field)             {b.td(:xpath => "//table[@summary='Items Section']/tbody/tr/td[1][b[contains(text(),'#{@line_number}')]]/following-sibling::td[8]")}
      element(:parts_to_be_received_field)                {b.td(:xpath => "//table[@summary='Items Section']/tbody/tr/td[1][b[contains(text(),'#{@line_number}')]]/following-sibling::td[9]")}
      element(:item_received_quantity_field)              {b.text_field(:id => "document.item[#{@line_id}].oleItemReceivedTotalQuantity")}
      element(:item_received_parts_field)                 {b.text_field(:id => "document.item[#{@line_id}].oleItemReceivedTotalParts")}
      element(:item_returned_quantity_field)              {b.text_field(:id => "document.item[#{@line_id}].oleItemReturnedTotalQuantity")}
      element(:item_returned_parts_field)                 {b.text_field(:id => "document.item[#{@line_id}].oleItemReturnedTotalParts")}
      element(:item_damaged_quantity_field)               {b.text_field(:id => "document.item[#{@line_id}].oleItemDamagedTotalQuantity")}
      element(:item_damaged_parts_field)                  {b.text_field(:id => "document.item[#{@line_id}].oleItemDamagedTotalParts")}
      element(:available_to_public_checkbox)              {b.checkbox(:id => "document.item[#{@line_id}].availableToPublic")}
      element(:public_view_checkbox)                      {b.checkbox(:id => "document.item[#{@line_id}].availableToPublic")}
      element(:exception_notes_toggle)                    {b.input(:xpath => "//tr[td/b[contains(text(),'#{@line_number}')]]/following-sibling::tr[2]/td[1]/table/tbody/tr[1]/th/div/input")}
      element(:receipt_notes_toggle)                      {b.input(:xpath => "//tr[td/b[contains(text(),'#{@line_number}')]]/following-sibling::tr[3]/td[1]/table/tbody/tr[1]/th/div/input")}
      element(:special_processing_instructions_toggle)    {b.input(:xpath => "//tr[td/b[contains(text(),'#{@line_number}')]]/following-sibling::tr[4]/td[1]/table/tbody/tr[1]/th/div/input")}
    end

    def create_exception_notes_line(which = 1)
      create_subline("exception_notes_line_#{which}","Exception_Notes_Line", which)
    end
    alias_method(:add_exception_notes_line,:create_exception_notes_line)

    def create_receipt_notes_line(which = 1)
      create_subline("receipt_notes_line_#{which}","Receipt_Notes_Line", which)
    end
    alias_method(:add_receipt_notes_line,:create_receipt_notes_line)

    def create_copies_line(which = 1)
      create_subline("copies_line_#{which}","Copies_Line", which)
    end
    alias_method(:add_copies_line,:create_copies_line)

    def create_processing_line(which = 1)
      create_subline("processing_line_#{which}","Processing_Line", which)
    end
    alias_method(:add_processing_line,:create_processing_line)

    def remove_exception_notes_line(which = 1)
      remove_subline("exception_notes_line_#{which}")
    end
    alias_method(:delete_exception_notes_line,:remove_exception_notes_line)

    def remove_receipt_notes_line(which = 1)
      remove_subline("receipt_notes_line_#{which}")
    end
    alias_method(:delete_receipt_notes_line,:remove_receipt_notes_line)

    def remove_copies_line(which = 1)
      remove_subline("copies_line_#{which}")
    end
    alias_method(:delete_copies_line,:remove_copies_line)

    def remove_processing_line(which = 1)
      remove_subline("processing_line_#{which}")
    end
    alias_method(:delete_processing_line,:remove_processing_line)
  end
end