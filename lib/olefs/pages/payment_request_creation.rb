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
  # A Payment Request Creation screen in the OLE Financial System
  class PREQ_Creation < E_Doc
    def initialize(ole_session)
      url = ole_session.fs_url + 'portal.do?channelTitle=Payment Request&channelUrl=selectOlePaymentRequest.do?methodToCall=docHandler&command=initiate&docTypeName=OLE_PREQ'
      super(ole_session, url)
    end

    # Set screen elements on PREQ Creation screen.
    def set_elements
      super
      element(:purchase_order_number_field)               {b.text_field(:id => "document.purchaseOrderIdentifier")}
      element(:invoice_number_field)                      {b.text_field(:id => "document.invoiceNumber")}
      element(:invoice_date_field)                        {b.text_field(:id => "document.invoiceDate")}
      element(:invoice_amount_field)                      {b.text_field(:id => "document.vendorInvoiceAmount")}
      element(:special_handling_line_1)                   {b.text_field(:id => "document.specialHandlingInstructionLine1Text")}
      element(:special_handling_line_2)                   {b.text_field(:id => "document.specialHandlingInstructionLine2Text")}
      element(:special_handling_line_3)                   {b.text_field(:id => "document.specialHandlingInstructionLine3Text")}
      element(:foreign_invoice_amount_field)              {b.text_field(:id => "document.foreignVendorInvoiceAmount")}
      element(:continue_button)                           {b.div(:id => "globalbuttons").input(:title => "Continue")}
      element(:clear_button)                              {b.div(:id => "globalbuttons").input(:title => "Clear")}
    end

    # Wait for #continue_button to appear before considering the page fully loaded.
    def wait_for_elements
      super
      @wait_on << :continue_button
    end
  end
end