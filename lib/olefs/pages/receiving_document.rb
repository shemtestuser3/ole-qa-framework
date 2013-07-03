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
  # An OLE Financial System Receiving Document
  class Receiving_Document < PURAP_Document
    def initialize(ole_session)
      new_receiving_doc_url = ole_session.fs_url + 'portal.do?channelTitle=Receiving&channelUrl=selectOleLineItemReceiving.do?methodToCall=docHandler&command=initiate&docTypeName=OLE_RCVL'
      super(ole_session, new_receiving_doc_url)
    end

    # Create a new receiving line object on the receiving document.
    def set_lines
      create_line("new_receiving_line","New_Receiving_Line")
    end

    # Set Receiving Doc screen elements.
    def set_elements
      super
      # Vendor Tab
      element(:date_received_field)                               {b.text_field(:id => "document.shipmentReceivedDate")}
      element(:packing_slip_number_field)                         {b.text_field(:id => "document.shipmentPackingSlipNumber")}
      element(:bill_of_lading_number_field)                       {b.text_field(:id => "document.shipmentBillOfLadingNumber")}
      element(:reference_number_field)                            {b.text_field(:id => "document.shipmentReferenceNumber")}
      element(:carrier_selector)                                  {b.select_list(:id => "document.carrierCode")}
    end

    def create_receiving_line(which = 1)
      create_line("receiving_line_#{which}","Receiving_Line",which)
    end
    alias_method(:add_receiving_line,:create_receiving_line)

    def remove_receiving_line(which = 1)
      remove_line("receiving_line_#{which}")
    end
    alias_method(:delete_receiving_line,:remove_receiving_line)
  end
end