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
  # The Return page in the OLE Library System.
  class Return < OLE_QA::Framework::Page
    def initialize(ole_session)
      url = ole_session.ls_url + 'portal.do?channelTitle=Loan&channelUrl='
      url += ole_session.ls_url + 'ole-kr-krad/loancontroller?viewId=ReturnItemView&methodToCall=start'
      super(ole_session, url)
    end

    # Set elements for return page.
    def set_elements
      # General Elements
      element(:loan_button)                               {b.button(:id => 'LoanScreenLinkView-buttons')}
      element(:end_session_button)                        {b.button(:id => 'endSessionButton')}
      # Checkin Elements
      element(:damaged_checkin_checkbox)                  {b.checkbox(:id => 'DamagedCheckIn_control')}
      element(:checkin_date_field)                        {b.text_field(:id => 'CheckInDate_control')}
      element(:checkin_time_field)                        {b.text_field(:id => 'CheckInTime_control')}
      element(:item_field)                                {b.text_field(:id => 'CheckInItem_control')}
      element(:item_search_button)                        {b.fieldset(:id => 'CheckInItem_fieldset').input(:title => 'Search Field')}
      element(:items_returned_toggle)                     {b.a(:id => 'ItemReturnedList-HorizontalBoxSection_toggle')}
      # Checkin Message Elements
      element(:checkin_message_box)                       {b.div(:id => 'MessagePopupSectionForReturn')}
      element(:return_button)                             {b.button(:id => 'returnBtn')}
      element(:do_not_return_button)                      {b.button(:id => 'noReturnBtn')}
      # Circulation desk elements
      element(:circulation_desk_selector)                 {b.select_list(:id => 'LoanCirculationDesk_control')}
      element(:circulation_desk_yes)                      {b.button(:id => 'ChangeCirculationLocationBtn')}
      element(:circulation_desk_no)                       {b.button(:id => 'CirculationLocationCloseBtn')}
    end

    # Wait for the loan button and item barcode field to be present.
    def wait_for_elements
      @wait_on << :loan_button
      @wait_on << :item_field
    end

    # Set commonly used functions on return page.
    def set_functions
      function(:item_barcode_link)                        {|which = 1|  b.div(:id => "returnBarcode_line#{which-1}").a}
      function(:item_title)                               {|which = 1|  b.span(:id => "returnTitle_line#{which-1}_control")}
      function(:item_author)                              {|which = 1|  b.span(:id => "returnAuthor_line#{which-1}_control")}
      function(:item_location)                            {|which = 1|  b.span(:id => "returnItemLocation_line#{which-1}_control")}
      function(:item_call_number)                         {|which = 1|  b.span(:id => "returnItemCallNumber_line#{which-1}_control")}
      function(:item_checkin_date)                        {|which = 1|  b.span(:id => "returnCheckInDate_line#{which-1}_control")}
      function(:item_status)                              {|which = 1|  b.span(:id => "returnItemStatus_line#{which-1}_control")}
      function(:item_bill_link)                           {|which = 1|  b.div(:id => "returnBill_line#{which-1}").a}
    end
  end
end