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
    @ole = OLE_QAF::Framework.new
    @browser = @ole.browser
    @line_number = 1
    @rcv_line = OLE_QAF::OLEFS::Receiving_Line.new(@browser, @line_number)
    @rcv_line_added = OLE_QAF::OLEFS::Receiving_Line.new(@browser, @line_number, new_line = false)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @rcv_line.class.should == OLE_QAF::OLEFS::Receiving_Line
    @rcv_line.class.superclass.should == OLE_QAF::Line_Object
  end

  it 'should have an appropriate YAML path' do
    @rcv_line.yaml_path.should == '/olefs/objects/receiving_line/'
  end

  it 'should have a browser accessor' do
    @rcv_line.browser.class.should == Selenium::WebDriver::Driver
  end

  it 'should have a line number of 1' do
    @rcv_line.line_number.should == 1
  end

  it 'should have a line identifier of 0' do
    @rcv_line.line_identifier.should == 0
  end

  it 'should have an add button' do
    @rcv_line.add_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have a new bib button' do
    @rcv_line.new_bib_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have receiving line fields' do
    @rcv_line.vendor_item_identifier_field.class.should == OLE_QAF::Input_Element
    @rcv_line.format_selector.class.should == OLE_QAF::Selector_Element
    @rcv_line.item_received_quantity_field.class.should == OLE_QAF::Input_Element
    @rcv_line.item_received_parts_field.class.should == OLE_QAF::Input_Element
    @rcv_line.item_returned_quantity_field.class.should == OLE_QAF::Input_Element
    @rcv_line.item_returned_parts_field.class.should == OLE_QAF::Input_Element
    @rcv_line.item_damaged_quantity_field.class.should == OLE_QAF::Input_Element
    @rcv_line.item_damaged_parts_field.class.should == OLE_QAF::Input_Element
    @rcv_line.addition_reason_selector.class.should == OLE_QAF::Selector_Element
    @rcv_line.available_to_public_checkbox.class.should == OLE_QAF::Checkbox_Element
    @rcv_line.public_view_checkbox.class.should == OLE_QAF::Checkbox_Element
  end

  it 'should have new fields' do
    @rcv_line_added.description_field.class.should == OLE_QAF::Data_Element
    @rcv_line_added.quantity_ordered_field.class.should == OLE_QAF::Data_Element
    @rcv_line_added.parts_ordered_field.class.should == OLE_QAF::Data_Element
    @rcv_line_added.prior_quantity_received_field.class.should == OLE_QAF::Data_Element
    @rcv_line_added.prior_parts_received_field.class.should == OLE_QAF::Data_Element
    @rcv_line_added.quantity_to_be_received_field.class.should == OLE_QAF::Data_Element
    @rcv_line_added.parts_to_be_received_field.class.should == OLE_QAF::Data_Element
    @rcv_line_added.item_received_quantity_field.class.should == OLE_QAF::Input_Element
    @rcv_line_added.item_received_parts_field.class.should == OLE_QAF::Input_Element
    @rcv_line_added.item_returned_quantity_field.class.should == OLE_QAF::Input_Element
    @rcv_line_added.item_returned_parts_field.class.should == OLE_QAF::Input_Element
    @rcv_line_added.item_damaged_quantity_field.class.should == OLE_QAF::Input_Element
    @rcv_line_added.item_damaged_parts_field.class.should == OLE_QAF::Input_Element
    @rcv_line_added.available_to_public_checkbox.class.should == OLE_QAF::Checkbox_Element
    @rcv_line_added.public_view_checkbox.class.should == OLE_QAF::Checkbox_Element
  end

  it 'should set all counters to 0' do
    @rcv_line_added.exception_notes_line_counter.should == 0
    @rcv_line_added.receipt_notes_line_counter.should == 0
    @rcv_line_added.processing_line_counter.should == 0
    @rcv_line_added.copies_line_counter.should == 0
  end

  it 'should have an exception notes line' do
    @rcv_line_added.new_exception_notes_line.class.should == OLE_QAF::OLEFS::Exception_Notes_Line
  end

  it 'should have a receipt notes line' do
    @rcv_line_added.new_receipt_notes_line.class.should == OLE_QAF::OLEFS::Receipt_Notes_Line
  end

  it 'should have a copies line' do
    @rcv_line_added.new_copies_line.class.should == OLE_QAF::OLEFS::Copies_Line
  end

  it 'should add an exception notes line' do
    @rcv_line_added.create_exception_notes_line
    @rcv_line_added.exception_notes_line_counter.should == 1
    @rcv_line_added.exception_notes_line_1.class.should == OLE_QAF::OLEFS::Exception_Notes_Line
  end

  it 'should delete an exception notes line' do
    @rcv_line_added.delete_exception_notes_line
    @rcv_line_added.exception_notes_line_counter.should == 0
    @rcv_line_added.exception_notes_line_1.class.should == NilClass
  end

  it 'should add a receipt notes line' do
    @rcv_line_added.create_receipt_notes_line
    @rcv_line_added.receipt_notes_line_counter.should == 1
    @rcv_line_added.receipt_notes_line_1.class.should == OLE_QAF::OLEFS::Receipt_Notes_Line
  end

  it 'should delete a receipt notes line' do
    @rcv_line_added.delete_receipt_notes_line
    @rcv_line_added.receipt_notes_line_counter.should == 0
    @rcv_line_added.receipt_notes_line_1.class.should == NilClass
  end

  it 'should add a processing line' do
    @rcv_line_added.create_processing_line
    @rcv_line_added.processing_line_counter.should == 1
    @rcv_line_added.processing_line_1.class.should == OLE_QAF::OLEFS::Processing_Line
  end

  it 'should delete a processing line' do
    @rcv_line_added.delete_processing_line
    @rcv_line_added.processing_line_counter.should == 0
    @rcv_line_added.processing_line_1.class.should == NilClass
  end

  it 'should add a copies line' do
    @rcv_line_added.create_copies_line
    @rcv_line_added.copies_line_counter.should == 1
    @rcv_line_added.copies_line_1.class.should == OLE_QAF::OLEFS::Copies_Line
  end

  it 'should delete a copies line' do
    @rcv_line_added.delete_copies_line
    @rcv_line_added.copies_line_counter.should == 0
    @rcv_line_added.copies_line_1.class.should == NilClass
  end
end