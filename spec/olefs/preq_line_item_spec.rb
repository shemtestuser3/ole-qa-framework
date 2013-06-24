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

describe 'An OLEFS Preq Line Item object' do

  before :all do
    @ole = OLE_QA::Framework.new
    @browser = @ole.browser
    @preq_line_item = OLE_QA::OLEFS::PREQ_Line_Item.new(@ole, 1)
    @new_preq_line = OLE_QA::OLEFS::New_PREQ_Line_Item.new(@ole, 1)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @preq_line_item.class.should == OLE_QA::OLEFS::PREQ_Line_Item
    @preq_line_item.class.superclass.should == OLE_QA::OLEFS::Line_Object
    @new_preq_line.class.should == OLE_QA::OLEFS::New_PREQ_Line_Item
    @new_preq_line.class.superclass.should == OLE_QA::OLEFS::Line_Object
  end

  it 'should have a browser accessor' do
    @preq_line_item.browser.class.should == @ole.browser.class
    @new_preq_line.browser.class.should == @ole.browser.class
  end

  it 'should have a line number of 1' do
    @preq_line_item.line_number.should == 1
  end

  it 'should have PREQ line item elements' do
    methods = @preq_line_item.methods
    methods.include?(:open_quantity_field).should be_true
    methods.include?(:po_unit_price_field).should be_true
    methods.include?(:format_field).should be_true
    methods.include?(:vendor_item_identifier_field).should be_true
    methods.include?(:prorated_surcharge_field).should be_true
    methods.include?(:unit_cost_field).should be_true
    methods.include?(:extended_cost_field).should be_true
    methods.include?(:assigned_to_trade_in_field).should be_true
    methods.include?(:description_field).should be_true
    methods.include?(:number_of_copies_ordered_field).should be_true
    methods.include?(:number_of_parts_ordered_field).should be_true
    methods.include?(:list_price_field).should be_true
    methods.include?(:discount_field).should be_true
    methods.include?(:discount_type_selector).should be_true
    methods.include?(:edit_bib_button).should be_true
    methods.include?(:delete_button).should be_true
    methods.include?(:invoice_notes_toggle).should be_true
    methods.include?(:accounting_lines_toggle).should be_true
  end

  it 'should have new PREQ line elements' do
    elements = @new_preq_line.methods
    elements.include?(:po_unit_price_field).should be_true
    elements.include?(:format_selector).should be_true
    elements.include?(:vendor_item_identifier_field).should be_true
    elements.include?(:number_of_copies_ordered_field).should be_true
    elements.include?(:number_of_parts_ordered_field).should be_true
    elements.include?(:list_price_field).should be_true
    elements.include?(:discount_field).should be_true
    elements.include?(:discount_type_selector).should be_true
    elements.include?(:assigned_to_trade_in_checkbox).should be_true
    elements.include?(:description_field).should be_true
    elements.include?(:new_bib_button).should be_true
    elements.include?(:receipt_status_selector).should be_true
    elements.include?(:add_button).should be_true
  end

  it 'should have sublines' do
    @preq_line_item.methods.include?(:new_invoice_notes_line).should be_true
    @preq_line_item.methods.include?(:new_accounting_line).should be_true
  end

  it 'should create additional sublines' do
    @preq_line_item.create_accounting_line(1)
    @preq_line_item.methods.include?(:accounting_line_1).should be_true
    @preq_line_item.accounting_line_1.class.should == OLE_QA::OLEFS::Accounting_Line
    @preq_line_item.create_invoice_notes_line(1)
    @preq_line_item.methods.include?(:invoice_notes_line_1).should be_true
    @preq_line_item.invoice_notes_line_1.class.should == OLE_QA::OLEFS::Invoice_Notes_Line
  end

  it 'should remove sublines' do
    @preq_line_item.remove_accounting_line(1)
    @preq_line_item.methods.include?(:accounting_line_1).should be_false
    @preq_line_item.remove_invoice_notes_line(1)
    @preq_line_item.methods.include?(:invoice_notes_line_1).should be_false
  end

  it 'should not remove sublines which do not exist' do
    lambda {@preq_line_item.remove_accounting_line(1)}.should raise_error
    lambda {@preq_line_item.remove_invoice_notes_line(1)}.should raise_error
  end
end