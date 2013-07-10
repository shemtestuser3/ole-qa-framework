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

require 'rspec'
require 'spec_helper'

describe 'An OLELS Loan page' do

  before :all do
    @ole = OLE_QA::Framework::Session.new
    @loan = OLE_QA::Framework::OLELS::Loan.new(@ole)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @loan.should be_an_instance_of(OLE_QA::Framework::OLELS::Loan)
    @loan.class.superclass.should == OLE_QA::Framework::Page
  end

  it 'should have loan screen elements' do
    elements = @loan.elements
    elements.include?(:circulation_desk_selector).should be_true
    elements.include?(:circulation_desk_yes).should be_true
    elements.include?(:circulation_desk_no).should be_true
    elements.include?(:patron_field).should be_true
    elements.include?(:patron_search_button).should be_true
    elements.include?(:item_field).should be_true
    elements.include?(:item_search_button).should be_true
    elements.include?(:fast_add_button).should be_true
    elements.include?(:loan_popup_box).should be_true
    elements.include?(:due_date_field).should be_true
    elements.include?(:due_time_field).should be_true
    elements.include?(:loan_button).should be_true
    elements.include?(:do_not_loan_button).should be_true
    elements.include?(:current_items_toggle).should be_true
    elements.include?(:checked_out_items_toggle).should be_true
    elements.include?(:loan_messages).should be_true
    elements.include?(:return_button).should be_true
    elements.include?(:header_close_button).should be_true
    elements.include?(:header_clear_patron_button).should be_true
    elements.include?(:header_alter_due_date_button).should be_true
    elements.include?(:header_claims_return_button).should be_true
    elements.include?(:header_renew_button).should be_true
    elements.include?(:clear_patron_button).should be_true
    elements.include?(:close_button).should be_true
    elements.include?(:alter_due_date_button).should be_true
    elements.include?(:claims_return_button).should be_true
    elements.include?(:renew_button).should be_true
    elements.include?(:patron_details_toggle).should be_true
    elements.include?(:patron_name).should be_true
    elements.include?(:patron_type).should be_true
    elements.include?(:patron_preferred_address).should be_true
    elements.include?(:patron_phone_number).should be_true
    elements.include?(:patron_email).should be_true
  end

  it 'should include loan screen functions' do
    functions = @loan.functions
    functions.include?(:item_selector).should be_true
    functions.include?(:item_barcode_link).should be_true
    functions.include?(:item_title).should be_true
    functions.include?(:item_author).should be_true
    functions.include?(:item_location).should be_true
    functions.include?(:item_call_number).should be_true
    functions.include?(:item_number_of_renewals).should be_true
    functions.include?(:item_due_date).should be_true
    functions.include?(:item_claims_return_note).should be_true
    functions.include?(:item_claims_return_date).should be_true
    functions.include?(:co_item_selector).should be_true
    functions.include?(:co_item_barcode_link).should be_true
    functions.include?(:co_item_title).should be_true
    functions.include?(:co_item_author).should be_true
    functions.include?(:co_item_location).should be_true
    functions.include?(:co_item_call_number).should be_true
    functions.include?(:co_item_number_of_renewals).should be_true
    functions.include?(:co_item_due_date).should be_true
    functions.include?(:co_item_claims_return_note).should be_true
    functions.include?(:co_item_claims_return_date).should be_true
  end

  it 'should open the loan screen via URL' do
    main_menu = OLE_QA::Framework::OLELS::Main_Menu.new(@ole)
    main_menu.open
    main_menu.login('dev2')
    @loan.open
    @loan.return_button.present?.should be_true
    @loan.circulation_desk_selector.present?.should be_true
    @loan.patron_field.present?.should be_true
  end
end