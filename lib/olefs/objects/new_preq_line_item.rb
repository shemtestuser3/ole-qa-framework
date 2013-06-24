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
  # A new Line Item on an OLE Financial System Payment Request Document.
  class New_PREQ_Line_Item < OLE_QA::OLEFS::Line_Object
    # Initialize as a subclass of {OLE_QA::OLEFS::Line_Object} with a line_number of 0.
    def initialize(ole_session, which)
      super(ole_session, 0)
    end

    # Set elements on a new PREQ line item.
    # @note No line number substitution will be involved as there is only ever
    #   one new line item on an OLEFS Receiving Document.
    def set_elements
      super
      element(:po_unit_price_field)                         {b.text_field(:id => "newPurchasingItemLine.purchaseOrderItemUnitPrice")}
      element(:format_selector)                             {b.select_list(:id => "newPurchasingItemLine.formatTypeId")}
      element(:vendor_item_identifier_field)                {b.text_field(:id => "newPurchasingItemLine.itemCatalogNumber")}
      element(:number_of_copies_ordered_field)              {b.text_field(:id => "newPurchasingItemLine.oleItemQuantity")}
      element(:number_of_parts_ordered_field)               {b.text_field(:id => "newPurchasingItemLine.itemNoOfParts")}
      element(:list_price_field)                            {b.text_field(:id => "newPurchasingItemLine.itemListPrice")}
      element(:discount_field)                              {b.text_field(:id => "newPurchasingItemLine.itemDiscount")}
      element(:discount_type_selector)                      {b.select_list(:id => "newPurchasingItemLine.itemDiscountType")}
      element(:assigned_to_trade_in_checkbox)               {b.checkbox(:id => "newPurchasingItemLine.itemAssignedToTradeInIndicator")}
      element(:description_field)                           {b.text_field(:id => "newPurchasingItemLine.itemDescription")}
      element(:new_bib_button)                              {b.input(:id => "bibCreateCurrentItemButton")}
      element(:receipt_status_selector)                     {b.select_list(:id => "newPurchasingItemLine.receiptStatusId")}
      element(:add_button)                                  {b.input(:name => "methodToCall.addItem")}
    end
  end
end