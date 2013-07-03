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
  # A new Receiving Line on an OLE Financial System Receiving Document.
  class New_Receiving_Line < OLE_QA::Framework::OLEFS::Line_Object
    # Initialize as a subclass of {OLE_QA::Framework::OLEFS::Line_Object} with a line_number of 0.
    def initialize(ole_session, which)
      super(ole_session, 0)
    end

    # Set elements on a new receiving line.
    # @note No line number substitution will be involved as there is only ever
    #   one new line item on an OLEFS Receiving Document.
    def set_elements
      super
      element(:vendor_item_identifier_field)                {b.text_field(:id => "newLineItemReceivingItemLine.itemCatalogNumber")}
      element(:format_selector)                             {b.select_list(:id => "newLineItemReceivingItemLine.oleFormatId")}
      element(:item_received_quantity_field)                {b.text_field(:id => "newLineItemReceivingItemLine.oleItemReceivedTotalQuantity")}
      element(:item_received_parts_field)                   {b.text_field(:id => "newLineItemReceivingItemLine.oleItemReceivedTotalParts")}
      element(:item_returned_quantity_field)                {b.text_field(:id => "newLineItemReceivingItemLine.oleItemReturnedTotalQuantity")}
      element(:item_returned_parts_field)                   {b.text_field(:id => "newLineItemReceivingItemLine.oleItemReturnedTotalParts")}
      element(:item_damaged_quantity_field)                 {b.text_field(:id => "newLineItemReceivingItemLine.oleItemDamagedTotalQuantity")}
      element(:item_damaged_parts_field)                    {b.text_field(:id => "newLineItemReceivingItemLine.oleItemDamagedTotalParts")}
      element(:addition_reason_selector)                    {b.select_list(:id => "newLineItemReceivingItemLine.itemReasonAddedCode")}
      element(:available_to_public_checkbox)                {b.checkbox(:id => "newLineItemReceivingItemLine.availableToPublic")}
      element(:public_view_checkbox)                        {b.checkbox(:id => "newLineItemReceivingItemLine.availableToPublic")}
      element(:new_bib_button)                              {b.input(:id => "bibCreateCurrentItemButton")}
    end
  end
end