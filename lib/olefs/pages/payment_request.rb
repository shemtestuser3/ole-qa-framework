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
  # An OLE Financial System Payment Request Document.
  class Payment_Request < PURAP_Document
    def initialize(ole_session)
      new_preq_url = ole_session.fs_url + 'portal.do?channelTitle=Payment Request&channelUrl=selectOlePaymentRequest.do?methodToCall=docHandler&command=initiate&docTypeName=OLE_PREQ'
      super(ole_session, new_preq_url)
    end

    # Create a new payment request line item on the payment request document.
    def set_lines
      create_line("new_line_item","New_PREQ_Line_Item")
    end

    # Set Payment Request document screen elements.
    def set_elements
      super
      # Invoice Info Tab
      element(:invoice_number_field)                        {b.td(:xpath => "//h3[contains(text(),'Invoice Info')]/following-sibling::table/tbody/tr[1]/td[1]")}
      element(:pay_date_field)                              {b.text_field(:id => "document.paymentRequestPayDate")}
      element(:invoice_date_field)                          {b.td(:xpath => "//h3[contains(text(),'Invoice Info')]/following-sibling::table/tbody/tr[3]/td[1]")}
      element(:immediate_pay_checkbox)                      {b.checkbox(:id => "document.immediatePaymentIndicator")}
      element(:payment_attachment_checkbox)                 {b.checkbox(:id => "document.paymentAttachmentIndicator")}
      element(:invoice_type_field)                          {b.text_field(:id => "document.oleInvoiceType.invoiceType")}
      element(:invoice_subtype_field)                       {b.text_field(:id => "document.oleInvoiceSubType.invoiceSubType")}
      element(:payment_method_selector)                     {b.select_list(:id => "document.paymentMethod.paymentMethodId")}
      # Titles Tab
      element(:grand_total_field)                           {b.b(:xpath => "//div[@id='tab-Titles-div']/descendant::th[div[contains(text(),'Grand Total')]]/following-sibling::td/div/b")}
      element(:additional_charges_toggle)                   {b.input(:id => "tab-AdditionalCharges-imageToggle")}
      element(:freight_extended_cost_field)                 {b.text_field(:id => "document.item[1].itemUnitPrice")}
      element(:freight_description_field)                   {b.text_field(:id => "document.item[1].description")}
      element(:shipping_handling_extended_cost_field)       {b.text_field(:id => "document.item[2].itemUnitPrice")}
      element(:shipping_handling_description_field)         {b.text_field(:id => "document.item[2].description")}
      element(:minimum_order_extended_cost_field)           {b.text_field(:id => "document.item[3].itemUnitPrice")}
      element(:minimum_order_description_field)             {b.text_field(:id => "document.item[3].description")}
      element(:misc_overhead_extended_cost_field)           {b.text_field(:id => "document.item[4].itemUnitPrice")}
      element(:misc_overhead_description_field)             {b.text_field(:id => "document.item[4].description")}
      element(:prorate_by_quantity_checkbox)                {b.checkbox(:id => "document.prorateQty")}
      element(:prorate_by_dollar_checkbox)                  {b.checkbox(:id => "document.prorateDollar")}
      element(:prorate_manual_checkbox)                     {b.checkbox(:id => "document.prorateManual")}
      element(:close_po_checkbox)                           {b.checkbox(:id => "document.closePurchaseOrderIndicator")}
    end

    def create_line_item(which = 1)
      create_line("line_item_#{which}","PREQ_Line_Item",which)
    end
    alias_method(:add_line_item,:create_line_item)

    def remove_line_item(which = 1)
      remove_line("line_item_#{which}")
    end
    alias_method(:delete_line_item,:remove_line_item)
  end
end