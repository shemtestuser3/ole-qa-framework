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
  # The Vendor Lookup Screen in OLEFS
  class Vendor_Lookup < Lookup
    # Set URL and initialize.
    def initialize(ole_session)
      # Set @url instance variable from OLE Base URL Variable
      url = ole_session.base_url + \
        'portal.do?channelTitle=Vendor&channelUrl=kr/lookup.do?methodToCall=start&businessObjectClassName=org.kuali.ole.vnd.businessobject.VendorDetail&docFormKey=88888888&returnLocation=' \
        + ole_session.base_url + \
        'portal.do&hideReturnLink=true'
      super(ole_session, url)
    end

    # Set Vendor Lookup screen elements.
    def set_elements
      super
      element(:vendor_name_field)                     {b.text_field(:id => "vendorName")}
      element(:tax_number_field)                      {b.text_field(:id => "vendorHeader.vendorTaxNumber")}
      element(:vendor_number_field)                   {b.text_field(:id => "vendorNumber")}
      element(:vendor_type_selector)                  {b.select_list(:id => "vendorHeader.vendorTypeCode")}
      element(:state_field)                           {b.text_field(:id => "vendorAddresses.vendorStateCode")}
      element(:commodity_code_field)                  {b.text_field(:id => "vendorCommodities.purchasingCommodityCode")}
      element(:supplier_diversity_selector)           {b.select_list(:id => "vendorHeader.vendorSupplierDiversities.vendorSupplierDiversityCode")}
    end
  end
end