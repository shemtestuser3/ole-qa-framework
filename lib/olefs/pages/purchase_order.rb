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
  # An OLE Financial System Purchase Order
  # - Many screen elements are identical to those of a Requisition
  # - Line Item handling is identical to that of a Requisition
  class Purchase_Order < PURAP_Document
    # Initialize with a URL of OLE_QA::Framework.base_url
    # @note OLEFS Purchase Orders do not have a direct link to open new documents.
    def initialize(ole_session)
      super(ole_session, ole_session.base_url)
    end

    # Create a new line item object on the purchase order.
    def set_lines
      create_line("new_line_item", "New_Line_Item")
    end

    # Set Purchase Order screen elements.
    def set_elements
      super
      # Purchase Order Detail Area
      element(:funding_source_selector)                           {b.select_list(:id => "document.documentFundingSourceCode")}
      # Additional Institutional Info Tab
      element(:additional_info_tab_toggle)                        {b.input(:id => "tab-AdditionalInstitutionalInfo-imageToggle")}
      element(:additional_info_phone_number_field)                                {b.text_field(:id => "document.requestorPersonPhoneNumber")}
      # Delivery Tab
      element(:room_field)                                        {b.text_field(:id => "document.deliveryBuildingRoomNumber")}
      element(:building_search_icon)                              {b.input(:xpath => "//div[@id='tab-Delivery-div']/descendant::tr[2]/th[1]/following-sibling::td[1]/input[1]")}
      element(:campus_search_icon)                                {b.input(:xpath => "//div[@id='tab-Delivery-div']/descendant::tr[1]/th[1]/following-sibling::td[1]/input[1]")}
      element(:delivery_phone_number_field)                       {b.text_field(:id => "document.deliveryToPhoneNumber")}
      # Vendor Tab
      element(:vendor_name_field)                                 {b.text_field(:id => "document.vendorName")}
      element(:vendor_search_icon)                                {b.input(:xpath => "//input[@id='document.vendorName']/following-sibling::input[1]")}
      # Titles Tab
      element(:grand_total_field)                                 {b.b(:xpath => "//div[@id='tab-Titles-div']/descendant::th[div[contains(text(),'Grand Total')]]/following-sibling::td/div/b")}
      # Input Buttons
      element(:sensitive_data_button)                             {b.input(:xpath => "//input[@title='Assign sensitive data to the PO']")}
      element(:payment_hold_button)                               {b.input(:xpath => "//input[@title='Payment Hold']")}
      element(:amend_button)                                      {b.input(:xpath => "//input[@title='Amend']")}
      element(:void_order_button)                                 {b.input(:xpath => "//input[@title='Void PO']")}
      element(:receiving_button)                                  {b.input(:xpath => "//input[@title='Receiving']")}
      element(:print_button)                                      {b.input(:xpath => "//input[@title='Print']")}
    end

    def create_line_item(which = 1)
      create_line("line_item_#{which}","Line_Item", which)
    end
    alias_method(:add_line_item,:create_line_item)

    def remove_line_item(which = 1)
      remove_line("line_item_#{which}")
    end
    alias_method(:delete_line_item,:remove_line_item)
  end
end