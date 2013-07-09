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

module OLE_QA::Framework::OLELS
  # The Patron lookup page in the OLE Library System.
  class Patron_Lookup < Lookup
    def initialize(ole_session)
      url = ole_session.ls_url + 'portal.do?channelTitle=Patron&channelUrl='
      url += ole_session.ls_url + 'ole-kr-krad/lookup?methodToCall=start&dataObjectClassName=org.kuali.ole.patron.bo.OlePatronDocument&returnLocation='
      url += ole_session.ls_url + 'portal.do&hideReturnLink=true&showMaintenanceLinks=true'
      super(ole_session, url)
    end

    # Set Patron Lookup elements.
    def set_elements
      super
      element(:patron_id_field)                 {b.text_field(:id => "olePatronId_control")}
      element(:barcode_field)                   {b.text_field(:id => "barcode_control")}
      element(:first_name_field)                {b.text_field(:id => "firstName_control")}
      element(:last_name_field)                 {b.text_field(:id => "lastName_control")}
      element(:borrower_type_selector)          {b.select_list(:id => "borrowerType_control")}
      element(:email_address_field)             {b.text_field(:id => "emailAddress_control")}
      # Search Controls
      # TODO Move these elements to OLE_QA::Framework::OLELS::Lookup (common) when they become universal.
      element(:active_yes_button)               {b.radio(:id => 'activeIndicator_control_0')}
      element(:active_no_button)                {b.radio(:id => 'activeIndicator_control_1')}
      element(:active_both_button)              {b.radio(:id => 'activeIndicator_control_2')}
      element(:search_button)                   {b.button(:text => "Search")}
      element(:clear_button)                    {b.button(:text => "Clear Values")}
      element(:cancel_button)                   {b.button(:text => "Cancel")}
    end
  end
end