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
  # A new Line Item on an OLE Financial System PURAP E-Document.
  class New_Line_Item < OLE_QA::Framework::OLEFS::Line_Object
    # Initialize as a subclass of {OLE_QA::Framework::OLEFS::Line_Object} with a line_number of 0.
    def initialize(ole_session, which)
      super(ole_session, 0)
    end

    # Set elements on a new line item.
    # @note No line number substitution will be involved as there is only ever
    #   one new line item on an OLEFS PURAP E-Document.
    def set_elements
      super
      element(:new_bib_button)                      {b.input(:id => "bibCreateCurrentItemButton")}
      element(:item_type_selector)                  {b.select_list(:id => "newPurchasingItemLine.itemTypeDescription")}
      element(:copies_field)                        {b.text_field(:id => "newPurchasingItemLine.oleItemQuantity")}
      element(:parts_field)                         {b.text_field(:id => "newPurchasingItemLine.itemNoOfParts")}
      element(:list_price_field)                    {b.text_field(:id => "newPurchasingItemLine.itemListPrice")}
      element(:public_view_checkbox)                {b.checkbox(:id => "newPurchasingItemLine.itemPublicViewIndicator")}
      element(:item_price_source_selector)          {b.select_list(:id => "newPurchasingItemLine.itemPriceSourceId")}
      element(:request_source_selector)             {b.select_list(:id => "newPurchasingItemLine.requestSourceTypeId")}
      element(:format_selector)                     {b.select_list(:id => "newPurchasingItemLine.formatTypeId")}
      element(:category_selector)                   {b.select_list(:id => "newPurchasingItemLine.categoryId")}
      element(:route_to_requestor_checkbox)         {b.checkbox(:id => "newPurchasingItemLine.itemRouteToRequestorIndicator")}
      element(:discount_field)                      {b.text_field(:id => "newPurchasingItemLine.itemDiscount")}
      element(:discount_type_selector)              {b.select_list(:id => "newPurchasingItemLine.itemDiscountType")}
      element(:add_button)                          {b.input(:name => "methodToCall.addItem")}
    end
  end
end