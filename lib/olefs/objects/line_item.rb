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
  # A single Line Item in an OLE Financial System PURAP E-Document.
  class Line_Item < OLE_QA::Framework::OLEFS::Line_Object
    # Create accessor methods for new subline objects.
    def set_sublines
      create_subline("new_accounting_line","New_Accounting_Line")
      create_subline("new_notes_line","New_Notes_Line")
      create_subline("new_copies_line","New_Copies_Line")
    end

    # Set line item elements.
    def set_elements
      super
      # Fields
      element(:copies_field)                      {b.text_field(:id => "document.item[#{@line_id}].oleItemQuantity")}
      element(:parts_field)                       {b.text_field(:id => "document.item[#{@line_id}].itemNoOfParts")}
      element(:list_price_field)                  {b.text_field(:id => "document.item[#{@line_id}].itemListPrice")}
      element(:discount_field)                    {b.text_field(:id => "document.item[#{@line_id}].itemDiscount")}
      element(:description_field)                 {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[1]/td[2]")}
      element(:item_type_field)                   {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[1]/td[3]")}
      element(:extended_cost_field)               {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[2]/td[3]")}
      element(:receipt_status_field)              {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[3]/td[1]")}
      # Selectors
      element(:item_price_source_selector)        {b.select_list(:id => "document.item[#{@line_id}].itemPriceSourceId")}
      element(:request_source_selector)           {b.select_list(:id => "document.item[#{@line_id}].requestSourceId")}
      element(:item_type_selector)                {b.select_list(:id => "document.item[#{@line_id}].itemTypeDescription")}
      element(:format_selector)                   {b.select_list(:id => "document.item[#{@line_id}].formatTypeId")}
      element(:category_selector)                 {b.select_list(:id => "document.item[#{@line_id}].categoryId")}
      element(:discount_type_selector)            {b.select_list(:id => "document.item[#{@line_id}].itemDiscountType")}
      # Buttons, Checkboxes, Etc.
      element(:delete_button)                     {b.input(:title => "Delete Item #{@line_number}")}
      element(:route_to_requestor_checkbox)       {b.checkbox(:id => "document.item[#{@line_id}].itemRouteToRequestor")}
      element(:public_view_checkbox)              {b.checkbox(:id => "document.item[#{@line_id}].itemPublicViewIndicator")}
      # Readonly Elements
      # Use these for closed, uneditable fields as with a pre-existing line item on a purchase order.
      element(:closed_description_field)          {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[1]/td[2]")}
      element(:closed_item_type_field)            {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[1]/td[3]")}
      element(:closed_extended_cost_field)        {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[2]/td[3]")}
      element(:closed_list_price_field)           {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[2]/td[4]")}
      element(:closed_copies_field)               {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[2]/td[1]")}
      element(:closed_parts_field)                {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[2]/td[2]")}
      element(:closed_receipt_status_field)       {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[3]/td[1]")}
      element(:closed_copies_received_field)      {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[3]/td[2]")}
      element(:closed_parts_received_field)       {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[3]/td[3]")}
      element(:closed_item_price_source_field)    {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[3]/td[4]")}
      element(:closed_request_source_field)       {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[3]/td[5]")}
      element(:closed_format_field)               {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[4]/td[1]")}
      element(:closed_category_field)             {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[4]/td[2]")}
      element(:closed_vendor_item_id_field)       {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[4]/td[3]")}
      element(:closed_requestor_field)            {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[4]/td[4]")}
      element(:closed_route_to_requestor_field)   {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[4]/td[5]")}
      element(:closed_unit_cost_field)            {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[5]/td[1]")}
      element(:closed_discount_field)             {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[5]/td[2]")}
      element(:closed_discount_type_field)        {b.td(:xpath => "//tr[td[@class='tab-subhead'][contains(text(),'Item #{@line_number}')]]/following-sibling::tr[5]/td[4]")}
      # Subtab Toggle Buttons                   # Matches all of type, then selects by index = @line_id (i.e. if @line_num is 1, index is 0)
      element(:accounting_lines_toggle)         {b.input(:id => /tab-AccountingLines[0-9]+-imageToggle/, :index => @line_id)}
      #element(:notes_toggle)                   #TBD - The notes and copies lines are treated as the same line for ID purposes.
      #element(:copies_toggle)                  # There is no reliable way of knowing which index either should have without being state-aware.
    end

    def create_accounting_line(which = 1)
      create_subline("accounting_line_#{which}","Accounting_Line", which)
    end
    alias_method(:add_accounting_line,:create_accounting_line)

    def create_notes_line(which = 1)
      create_subline("notes_line_#{which}","Notes_Line", which)
    end
    alias_method(:add_notes_line,:create_notes_line)

    def create_copies_line(which = 1)
      create_subline("copies_line_#{which}","Copies_Line", which)
    end
    alias_method(:add_copies_line,:create_copies_line)

    def remove_accounting_line(which = 1)
      remove_subline("accounting_line_#{which}")
    end
    alias_method(:delete_accounting_line,:remove_accounting_line)

    def remove_notes_line(which = 1)
      remove_subline("notes_line_#{which}")
    end
    alias_method(:delete_notes_line,:remove_notes_line)

    def remove_copies_line(which = 1)
      remove_subline("copies_line_#{which}")
    end
    alias_method(:delete_copies_line,:remove_copies_line)
  end
end