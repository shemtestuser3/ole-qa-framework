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

describe 'An OLEFS Receiving Line object' do

  before :all do
    @ole = OLE_QA::Framework.new
    @browser = @ole.browser
    @line_number = 1
    @rcv_line = OLE_QA::OLEFS::Receiving_Line.new(@ole, @line_number)
    @new_rcv_line = OLE_QA::OLEFS::New_Receiving_Line.new(@ole, @line_number)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @rcv_line.class.should == OLE_QA::OLEFS::Receiving_Line
    @rcv_line.class.superclass.should == OLE_QA::OLEFS::Line_Object
    @new_rcv_line.class.should == OLE_QA::OLEFS::New_Receiving_Line
    @new_rcv_line.class.superclass.should == OLE_QA::OLEFS::Line_Object
  end

  it 'should have a browser accessor' do
    @rcv_line.browser.class.should == @ole.browser.class
    @new_rcv_line.browser.class.should == @ole.browser.class
  end

  it 'should have a line number' do
    @rcv_line.line_number.should == 1
    @new_rcv_line.line_number.should == 0
  end

  it 'should have receiving line elements' do
    methods = @rcv_line.methods
    methods.include?(:description_field).should be_true
    methods.include?(:quantity_ordered_field).should be_true
    methods.include?(:parts_ordered_field).should be_true
    methods.include?(:prior_quantity_received_field).should be_true
    methods.include?(:prior_parts_received_field).should be_true
    methods.include?(:quantity_to_be_received_field).should be_true
    methods.include?(:parts_to_be_received_field).should be_true
    methods.include?(:item_received_quantity_field).should be_true
    methods.include?(:item_received_parts_field).should be_true
    methods.include?(:item_returned_quantity_field).should be_true
    methods.include?(:item_returned_parts_field).should be_true
    methods.include?(:item_damaged_quantity_field).should be_true
    methods.include?(:item_damaged_parts_field).should be_true
    methods.include?(:available_to_public_checkbox).should be_true
    methods.include?(:public_view_checkbox).should be_true
    methods.include?(:exception_notes_toggle).should be_true
    methods.include?(:receipt_notes_toggle).should be_true
    methods.include?(:special_processing_instructions_toggle).should be_true
  end

  it 'should have subline objects' do
    @rcv_line.methods.include?(:new_exception_notes_line).should be_true
    @rcv_line.methods.include?(:new_receipt_notes_line).should be_true
    @rcv_line.methods.include?(:new_copies_line).should be_true
  end

  it 'should add sublines' do
    @rcv_line.create_exception_notes_line(1)
    @rcv_line.methods.include?(:exception_notes_line_1).should be_true
    @rcv_line.exception_notes_line_1.class.should == OLE_QA::OLEFS::Exception_Notes_Line
    @rcv_line.create_receipt_notes_line(1)
    @rcv_line.methods.include?(:receipt_notes_line_1).should be_true
    @rcv_line.receipt_notes_line_1.class.should == OLE_QA::OLEFS::Receipt_Notes_Line
    @rcv_line.create_copies_line(1)
    @rcv_line.methods.include?(:copies_line_1).should be_true
    @rcv_line.copies_line_1.class.should == OLE_QA::OLEFS::Copies_Line
    @rcv_line.create_processing_line(1)
    @rcv_line.methods.include?(:processing_line_1).should be_true
    @rcv_line.processing_line_1.class.should == OLE_QA::OLEFS::Processing_Line
  end

  it 'should remove sublines' do
    @rcv_line.remove_exception_notes_line(1)
    @rcv_line.remove_receipt_notes_line(1)
    @rcv_line.remove_copies_line(1)
    @rcv_line.remove_processing_line(1)
    @rcv_line.methods.include?(:exception_notes_line_1).should be_false
    @rcv_line.methods.include?(:receipt_notes_line_1).should be_false
    @rcv_line.methods.include?(:copies_line_1).should be_false
    @rcv_line.methods.include?(:processing_line_1).should be_false
  end

  it 'should raise an error when asked to remove sublines which do not exist' do
    lambda {@rcv_line.remove_exception_notes_line(1)}.should raise_error
    lambda {@rcv_line.remove_receipt_notes_line(1)}.should raise_error
    lambda {@rcv_line.remove_copies_line(1)}.should raise_error
    lambda {@rcv_line.remove_processing_line(1)}.should raise_error
  end

  it 'should have new receiving line elements' do
    elements = @new_rcv_line.methods
    elements.include?(:vendor_item_identifier_field).should be_true
    elements.include?(:format_selector).should be_true
    elements.include?(:item_received_quantity_field).should be_true
    elements.include?(:item_received_parts_field).should be_true
    elements.include?(:item_returned_quantity_field).should be_true
    elements.include?(:item_returned_parts_field).should be_true
    elements.include?(:item_damaged_quantity_field).should be_true
    elements.include?(:item_damaged_parts_field).should be_true
    elements.include?(:addition_reason_selector).should be_true
    elements.include?(:available_to_public_checkbox).should be_true
    elements.include?(:public_view_checkbox).should be_true
    elements.include?(:new_bib_button).should be_true
  end
end