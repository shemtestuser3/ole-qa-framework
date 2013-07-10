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
  # The Loan page in the OLE Library System.
  class Loan < OLE_QA::Framework::Page
    def initialize(ole_session)
      url = ole_session.ls_url + 'portal.do?channelTitle=Loan&channelUrl='
      url += ole_session.ls_url + 'ole-kr-krad/loancontroller?viewId=PatronItemView&methodToCall=start'
      super(ole_session, url)
    end

    # Set elements for loan page.
    def set_elements
      super
      # Circulation desk elements
      element(:circulation_desk_selector)                 {b.select_list(:id => 'LoanCirculationDesk_control')}
      element(:circulation_desk_yes)                      {b.button(:id => 'ChangeCirculationLocationBtn')}
      element(:circulation_desk_no)                       {b.button(:id => 'CirculationLocationCloseBtn')}
      # Loan Elements
      element(:patron_field)                              {b.text_field(:id => 'Patron-barcode_control')}
      element(:patron_search_button)                      {b.fieldset(:id => 'Patron-barcode_fieldset').input(:title => "Search Field")}
      element(:item_field)                                {b.text_field(:id => 'Patron-item_control')}
      element(:item_search_button)                        {b.fieldset(:id => 'Patron-item_fieldset').input(:title => "Search Field")}
      element(:fast_add_button)                           {b.button(:id => 'FastAddItemSectionLink')}
      element(:loan_popup_box)                            {b.div(:id => "MessagePopupSection")}
      element(:due_date_field)                            {b.text_field(:id => 'popUpDate_control')}
      element(:due_time_field)                            {b.text_field(:id => 'popUpTime_control')}
      element(:loan_button)                               {b.button(:id => 'loanBtn')}
      element(:do_not_loan_button)                        {b.button(:id => 'noLoanBtn')}
      # Current Item Elements
      element(:current_items_toggle)                      {b.a(:id => 'Patron-LoanItemListSection-HorizontalBoxSection_toggle').span}
      element(:checked_out_items_toggle)                  {b.a(:id => 'Patron-ExistingLoanItemListSection-HorizontalBoxSection_toggle').span}
      # General
      element(:loan_messages)                             {b.div(:id => 'LoanMessageFieldSection').spans(:class => 'uif-message')}
      element(:return_button)                             {b.button(:id => 'ReturnLinkView-buttons')}
      element(:header_close_button)                       {b.button(:id => 'headerDoneButton')}
      element(:header_clear_patron_button)                {b.button(:id => 'headerClearPatronButton')}
      element(:header_alter_due_date_button)              {b.button(:id => 'headerEditDueDateButton')}
      element(:header_claims_return_button)               {b.button(:id => 'headerClaimsButton')}
      element(:header_renew_button)                       {b.button(:id => 'headerRenewalButton')}
      element(:clear_patron_button)                       {b.button(:id => 'clearPatronButton')}
      element(:close_button)                              {b.button(:id => 'doneButton')}
      element(:alter_due_date_button)                     {b.button(:id => 'editDueDateButton')}
      element(:claims_return_button)                      {b.button(:id => 'claimsButton')}
      element(:renew_button)                              {b.button(:id => 'renewalButton')}
      # Patron Details Area
      element(:patron_details_toggle)                     {b.a(:id => 'PatronDetailList-HorizontalBoxSection_toggle').span(:class => "uif-headerText-span")}
      element(:patron_name)                               {b.div(:id => 'patronName').a}
      element(:patron_type)                               {b.span(:id => 'patronType_control')}
      element(:patron_preferred_address)                  {b.span(:id => 'patronPreferredAddress_control')}
      element(:patron_phone_number)                       {b.span(:id => 'patronPhone_control')}
      element(:patron_email)                              {b.span(:id => 'patronEmail_control')}
    end

    # Wait for the return button to be present.
    def wait_for_elements
      super
      @wait_on << :return_button
      @wait_on << :circulation_desk_selector
    end

    # Set commonly-used functions for loan screen.
    def set_functions
      # Current Item Functions - Pass a (1-based) numerical position to refer to a specific item line.
      # (Defaults to 1.)
      function(:item_selector)                            {|which = 1|  b.checkbox(:id => "checkId_line#{which-1}_control")}
      function(:item_barcode_link)                        {|which = 1|  b.div(:id => "Barcode_line#{which-1}").a}
      function(:item_title)                               {|which = 1|  b.span(:id => "title_line#{which-1}_control")}
      function(:item_author)                              {|which = 1|  b.span(:id => "author_line#{which-1}_control")}
      function(:item_location)                            {|which = 1|  b.span(:id => "itemLocation_line#{which-1}_control")}
      function(:item_call_number)                         {|which = 1|  b.span(:id => "itemCallNumber_line#{which-1}_control")}
      function(:item_number_of_renewals)                  {|which = 1|  b.span(:id => "currentNoOfrenew_line#{which-1}_control")}
      function(:item_due_date)                            {|which = 1|  b.span(:id => "loanDueDate_line#{which-1}_control")}
      function(:item_claims_return_note)                  {|which = 1|  b.span(:id => "claimsReturnNote_line#{which-1}_control")}
      function(:item_claims_return_date)                  {|which = 1|  b.span(:id => "claimsReturnDate_line#{which-1}_control")}
      # Checked Out Items Functions - Pass a (1-based) numerical position to refer to a specific item line.
      # (Defaults to 1.)
      function(:co_item_selector)                         {|which = 1|  b.checkbox(:id => "checkIdRenewal_line#{which-1}_control")}
      function(:co_item_barcode_link)                     {|which = 1|  b.div(:id => "BarcodeRenewal_line#{which-1}").a}
      function(:co_item_title)                            {|which = 1|  b.span(:id => "titleRenewal_line#{which-1}_control")}
      function(:co_item_author)                           {|which = 1|  b.span(:id => "authorRenewal_line#{which-1}_control")}
      function(:co_item_location)                         {|which = 1|  b.span(:id => "itemLocationRenewal_line#{which-1}_control")}
      function(:co_item_call_number)                      {|which = 1|  b.span(:id => "itemCallNumberRenewal_line#{which-1}_control")}
      function(:co_item_number_of_renewals)               {|which = 1|  b.span(:id => "previousNoOfrenew_line#{which-1}_control")}
      function(:co_item_due_date)                         {|which = 1|  b.span(:id => "loanDueDateRenewal_line#{which-1}_control")}
      function(:co_item_claims_return_note)               {|which = 1|  b.span(:id => "claimsReturnNoteRenewal_line#{which-1}_control")}
      function(:co_item_claims_return_date)               {|which = 1|  b.span(:id => "claimsReturnDateRenewal_line#{which-1}_control")}
    end
  end
end