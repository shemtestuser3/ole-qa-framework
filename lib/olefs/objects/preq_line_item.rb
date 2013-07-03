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
  # A single Line Item in an OLE Financial System Payment Request.
  class PREQ_Line_Item < OLE_QA::Framework::OLEFS::Line_Object
    # Create accessor methods for new subline objects.
    def set_sublines
      create_subline("new_invoice_notes_line","New_Invoice_Notes_Line")
      create_subline("new_accounting_line","New_Accounting_Line")
    end

    # Set PREQ line item elements.
    def set_elements
      super
      # Read-Only Elements
      element(:open_quantity_field)                           {b.td(:xpath => "//div[@id='tab-ProcessItems-div']/descendant::table/tbody/tr[th[contains(text(),'Item Line #')]]/following-sibling::tr[td/b[contains(text(),'#{@line_number}')]]/td[2]")}
      element(:po_unit_price_field)                           {b.td(:xpath => "//div[@id='tab-ProcessItems-div']/descendant::table/tbody/tr[th[contains(text(),'Item Line #')]]/following-sibling::tr[td/b[contains(text(),'#{@line_number}')]]/td[3]")}
      element(:format_field)                                  {b.td(:xpath => "//div[@id='tab-ProcessItems-div']/descendant::table/tbody/tr[th[contains(text(),'Item Line #')]]/following-sibling::tr[td/b[contains(text(),'#{@line_number}')]]/td[4]")}
      element(:vendor_item_identifier_field)                  {b.td(:xpath => "//div[@id='tab-ProcessItems-div']/descendant::table/tbody/tr[th[contains(text(),'Item Line #')]]/following-sibling::tr[td/b[contains(text(),'#{@line_number}')]]/td[5]")}
      element(:prorated_surcharge_field)                      {b.td(:xpath => "//div[@id='tab-ProcessItems-div']/descendant::table/tbody/tr[th[contains(text(),'Item Line #')]]/following-sibling::tr[td/b[contains(text(),'#{@line_number}')]]/td[11]")}
      element(:unit_cost_field)                               {b.td(:xpath => "//div[@id='tab-ProcessItems-div']/descendant::table/tbody/tr[th[contains(text(),'Item Line #')]]/following-sibling::tr[td/b[contains(text(),'#{@line_number}')]]/td[12]")}
      element(:extended_cost_field)                           {b.td(:xpath => "//div[@id='tab-ProcessItems-div']/descendant::table/tbody/tr[th[contains(text(),'Item Line #')]]/following-sibling::tr[td/b[contains(text(),'#{@line_number}')]]/td[13]")}
      element(:assigned_to_trade_in_field)                    {b.td(:xpath => "//div[@id='tab-ProcessItems-div']/descendant::table/tbody/tr[th[contains(text(),'Item Line #')]]/following-sibling::tr[td/b[contains(text(),'#{@line_number}')]]/td[14]")}
      element(:description_field)                             {b.td(:xpath => "//div[@id='tab-ProcessItems-div']/descendant::table/tbody/tr[th[contains(text(),'Item Line #')]]/following-sibling::tr[td/b[contains(text(),'#{@line_number}')]]/td[15]")}
      element(:number_of_copies_ordered_field)                {b.text_field(:id => "document.item[#{@line_id}].oleItemQuantity")}
      element(:number_of_parts_ordered_field)                 {b.text_field(:id => "document.item[#{@line_id}].itemNoOfParts")}
      element(:list_price_field)                              {b.text_field(:id => "document.item[#{@line_id}].itemListPrice")}
      element(:discount_field)                                {b.text_field(:id => "document.item[#{@line_id}].itemDiscount")}
      element(:discount_type_selector)                        {b.select_list(:id => "document.item[#{@line_id}].itemDiscountType")}
      element(:edit_bib_button)                               {b.input(:id => "bibEditAddedItemButton_#{@line_id}")}
      element(:delete_button)                                 {b.input(:xpath => "//input[@name='methodToCall.deleteItem.line#{@line_id}']")}
      element(:invoice_notes_toggle)                          {b.input(:xpath => "//div[@id='tab-ProcessItems-div']/descendant::table/tbody/tr[th[contains(text(),'Item Line #')]]/following-sibling::tr[td/b[contains(text(),'#{@line_number}')]]/following-sibling::tr[2]/descendant::input[starts-with(@id,'tab-Notes')]")}
      element(:accounting_lines_toggle)                       {b.input(:xpath => "//div[@id='tab-ProcessItems-div']/descendant::table/tbody/tr[th[contains(text(),'Item Line #')]]/following-sibling::tr[td/b[contains(text(),'#{@line_number}')]]/following-sibling::tr[3]/descendant::input[starts-with(@id,'tab-AccountingLines')]")}
    end

    def create_invoice_notes_line(which = 1)
      create_subline("invoice_notes_line_#{which}","Invoice_Notes_Line", which)
    end
    alias_method(:add_invoice_notes_line,:create_invoice_notes_line)

    def create_accounting_line(which = 1)
      create_subline("accounting_line_#{which}","Accounting_Line", which)
    end
    alias_method(:add_accounting_line,:create_accounting_line)

    def remove_invoice_notes_line(which = 1)
      remove_subline("invoice_notes_line_#{which}")
    end
    alias_method(:delete_invoice_notes_line,:remove_invoice_notes_line)

    def remove_accounting_line(which = 1)
      remove_subline("accounting_line_#{which}")
    end
    alias_method(:delete_accounting_line,:remove_accounting_line)
  end
end