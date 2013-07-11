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

describe 'My behaviour' do

  before :all do
    @ole = OLE_QA::Framework::Session.new
    @return_screen = OLE_QA::Framework::OLELS::Return.new(@ole)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @return_screen.should be_an_instance_of(OLE_QA::Framework::OLELS::Return)
    @return_screen.class.superclass.should == OLE_QA::Framework::Page
  end

  it 'should have return screen elements' do
    elements = @return_screen.elements
    elements.include?(:loan_button).should be_true
    elements.include?(:end_session_button).should be_true
    elements.include?(:damaged_checkin_checkbox).should be_true
    elements.include?(:checkin_date_field).should be_true
    elements.include?(:checkin_time_field).should be_true
    elements.include?(:item_field).should be_true
    elements.include?(:item_search_button).should be_true
    elements.include?(:items_returned_toggle).should be_true
    elements.include?(:checkin_message_box).should be_true
    elements.include?(:return_button).should be_true
    elements.include?(:do_not_return_button).should be_true
    elements.include?(:circulation_desk_selector).should be_true
    elements.include?(:circulation_desk_yes).should be_true
    elements.include?(:circulation_desk_no).should be_true
  end

  it 'should have return screen functions' do
    functions = @return_screen.functions
    functions.include?(:item_barcode_link).should be_true
    functions.include?(:item_title).should be_true
    functions.include?(:item_author).should be_true
    functions.include?(:item_location).should be_true
    functions.include?(:item_call_number).should be_true
    functions.include?(:item_checkin_date).should be_true
    functions.include?(:item_status).should be_true
    functions.include?(:item_bill_link).should be_true
  end

  it 'should open the return screen via URL' do
    main_menu = OLE_QA::Framework::OLELS::Main_Menu.new(@ole)
    main_menu.open
    main_menu.login('dev2')
    @return_screen.open
    @return_screen.loan_button.present?.should be_true
    @return_screen.item_field.present?.should be_true
  end
end