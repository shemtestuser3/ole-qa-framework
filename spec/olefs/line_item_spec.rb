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


describe 'An OLEFS line item' do

  before :all do
    @ole = OLE_QA::Framework::Session.new
    @line_number = 1
    @line_item = OLE_QA::Framework::OLEFS::Line_Item.new(@ole, @line_number)
    @new_line_item = OLE_QA::Framework::OLEFS::New_Line_Item.new(@ole, @line_number)
  end

  it 'should should create a new instance' do
    @line_item.class.should == OLE_QA::Framework::OLEFS::Line_Item
    @new_line_item.class.should == OLE_QA::Framework::OLEFS::New_Line_Item
  end

  it 'should be a subclass of Line Object' do
    @line_item.class.superclass.should == OLE_QA::Framework::OLEFS::Line_Object
    @new_line_item.class.superclass.should == OLE_QA::Framework::OLEFS::Line_Object
  end

  it 'should have a browser accessor' do
    @line_item.browser.class.should == @ole.browser.class
    @new_line_item.browser.class.should == @ole.browser.class
  end

  it 'should have line number attributes' do
    @line_item.line_number.should == 1
    @new_line_item.line_number.should == 0
  end

  it 'should have line item elements' do
    methods_array = @line_item.methods
    methods_array.include?(:copies_field).should be_true
    methods_array.include?(:parts_field).should be_true
    methods_array.include?(:list_price_field).should be_true
    methods_array.include?(:discount_field).should be_true
    methods_array.include?(:item_price_source_selector).should be_true
    methods_array.include?(:request_source_selector).should be_true
    methods_array.include?(:item_type_selector).should be_true
    methods_array.include?(:format_selector).should be_true
    methods_array.include?(:category_selector).should be_true
    methods_array.include?(:discount_type_selector).should be_true
    methods_array.include?(:delete_button).should be_true
    methods_array.include?(:route_to_requestor_checkbox).should be_true
    methods_array.include?(:public_view_checkbox).should be_true
    methods_array.include?(:accounting_lines_toggle).should be_true
    methods_array.include?(:description_field).should be_true
    methods_array.include?(:item_type_field).should be_true
    methods_array.include?(:extended_cost_field).should be_true
    methods_array.include?(:receipt_status_field).should be_true
    methods_array.include?(:closed_description_field).should be_true
    methods_array.include?(:closed_item_type_field).should be_true
    methods_array.include?(:closed_extended_cost_field).should be_true
    methods_array.include?(:closed_list_price_field).should be_true
    methods_array.include?(:closed_copies_field).should be_true
    methods_array.include?(:closed_parts_field).should be_true
    methods_array.include?(:closed_receipt_status_field).should be_true
    methods_array.include?(:closed_copies_received_field).should be_true
    methods_array.include?(:closed_parts_received_field).should be_true
    methods_array.include?(:closed_item_price_source_field).should be_true
    methods_array.include?(:closed_request_source_field).should be_true
    methods_array.include?(:closed_format_field).should be_true
    methods_array.include?(:closed_category_field).should be_true
    methods_array.include?(:closed_vendor_item_id_field).should be_true
    methods_array.include?(:closed_requestor_field).should be_true
    methods_array.include?(:closed_route_to_requestor_field).should be_true
    methods_array.include?(:closed_unit_cost_field).should be_true
    methods_array.include?(:closed_discount_field).should be_true
    methods_array.include?(:closed_discount_type_field).should be_true
    #TODO add the methods below when OLE-4329 is fixed.
    # methods_array.include?(:notes_toggle).should be_true
    # methods_array.include(:copies_toggle).should be_true
  end

  it 'should have subline objects' do
    methods = @line_item.methods
    methods.include?(:new_accounting_line).should be_true
    methods.include?(:new_notes_line).should be_true
    methods.include?(:new_copies_line).should be_true
  end

  it 'should have new line item elements' do
    elements = @new_line_item.methods
    elements.include?(:new_bib_button).should be_true
    elements.include?(:item_type_selector).should be_true
    elements.include?(:copies_field).should be_true
    elements.include?(:parts_field).should be_true
    elements.include?(:list_price_field).should be_true
    elements.include?(:public_view_checkbox).should be_true
    elements.include?(:item_price_source_selector).should be_true
    elements.include?(:request_source_selector).should be_true
    elements.include?(:format_selector).should be_true
    elements.include?(:category_selector).should be_true
    elements.include?(:route_to_requestor_checkbox).should be_true
    elements.include?(:discount_field).should be_true
    elements.include?(:discount_type_selector).should be_true
    elements.include?(:add_button).should be_true
  end

  it 'should create an accounting line' do
    @line_item.create_accounting_line(1)
    @line_item.methods.include?(:accounting_line_1).should be_true
    @line_item.accounting_line_1.class.should == OLE_QA::Framework::OLEFS::Accounting_Line
  end

  it 'should create a notes line' do
    @line_item.create_notes_line(1)
    @line_item.methods.include?(:notes_line_1).should be_true
    @line_item.notes_line_1.class.should == OLE_QA::Framework::OLEFS::Notes_Line
  end

  it 'should create a copies line' do
    @line_item.create_copies_line(1)
    @line_item.methods.include?(:copies_line_1).should be_true
    @line_item.copies_line_1.class.should == OLE_QA::Framework::OLEFS::Copies_Line
  end

  it 'should remove an accounting line' do
    @line_item.remove_accounting_line(1)
    @line_item.methods.include?(:accounting_line_1).should be_false
  end

  it 'should remove a notes line' do
    @line_item.remove_notes_line(1)
    @line_item.methods.include?(:notes_line_1).should be_false
  end

  it 'should remove a copies line' do
    @line_item.remove_copies_line(1)
    @line_item.methods.include?(:copies_line_1).should be_false
  end

  it 'should raise an error when asked to remove a subline which does not exist' do
    lambda {@line_item.remove_accounting_line(1)}.should raise_error
    lambda {@line_item.remove_notes_line(1)}.should raise_error
    lambda {@line_item.remove_copies_line(1)}.should raise_error
  end
end