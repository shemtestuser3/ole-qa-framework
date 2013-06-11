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
    @ole = OLE_QAF::Framework.new
    @browser = @ole.browser
    @preq_line_item = OLE_QAF::OLEFS::PREQ_Line_Item.new(@browser, 1)
    @preq_line_item_added = OLE_QAF::OLEFS::PREQ_Line_Item.new(@browser, 1, new_line = false)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @preq_line_item.class.should == OLE_QAF::OLEFS::PREQ_Line_Item
    @preq_line_item.class.superclass.should == OLE_QAF::Line_Object
  end

  it 'should have an appropriate YAML path' do
    @preq_line_item.yaml_path.should == '/olefs/objects/preq_line_item/'
  end

  it 'should have a browser accessor' do
    @preq_line_item.browser.class.should == @browser.class
  end

  it 'should have a line number of 1' do
    @preq_line_item.line_number.should == 1
  end

  it 'should have an add button' do
    @preq_line_item.add_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have a new bib button' do
    @preq_line_item.new_bib_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have preq line item fields' do
    @preq_line_item.po_unit_price_field.class.should == OLE_QAF::Input_Element
    @preq_line_item.format_selector.class.should == OLE_QAF::Selector_Element
    @preq_line_item.vendor_item_identifier_field.class.should == OLE_QAF::Input_Element
    @preq_line_item.number_of_copies_ordered_field.class.should == OLE_QAF::Input_Element
    @preq_line_item.number_of_parts_ordered_field.class.should == OLE_QAF::Input_Element
    @preq_line_item.list_price_field.class.should == OLE_QAF::Input_Element
    @preq_line_item.discount_field.class.should == OLE_QAF::Input_Element
    @preq_line_item.discount_type_selector.class.should == OLE_QAF::Selector_Element
    @preq_line_item.assigned_to_trade_in_checkbox.class.should == OLE_QAF::Checkbox_Element
    @preq_line_item.description_field.class.should == OLE_QAF::Input_Element
    @preq_line_item.receipt_status_selector.class.should == OLE_QAF::Selector_Element
  end

  it 'should have an edit bib button after being added' do
    @preq_line_item_added.edit_bib_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have a new accounting line' do
    @preq_line_item_added.new_accounting_line.class.should == OLE_QAF::OLEFS::Accounting_Line
    @preq_line_item_added.accounting_line_counter.should == 0
  end

  it 'should create an accounting line' do
    @preq_line_item_added.create_accounting_line
    @preq_line_item_added.accounting_line_1.class.should == OLE_QAF::OLEFS::Accounting_Line
    @preq_line_item_added.accounting_line_counter.should == 1
  end

  it 'should delete an accounting line' do
    @preq_line_item_added.delete_accounting_line
    @preq_line_item_added.accounting_line_1.class.should == NilClass
    @preq_line_item_added.accounting_line_counter.should == 0
  end

  it 'should have an invoice notes line' do
    @preq_line_item_added.new_invoice_notes_line.class.should == OLE_QAF::OLEFS::Invoice_Notes_Line
    @preq_line_item_added.invoice_notes_line_counter.should == 0
  end

  it 'should create an invoice notes line' do
    @preq_line_item_added.create_invoice_notes_line
    @preq_line_item_added.invoice_notes_line_1.class.should == OLE_QAF::OLEFS::Invoice_Notes_Line
    @preq_line_item_added.invoice_notes_line_counter.should == 1
  end

  it 'should delete an invoice notes line' do
    @preq_line_item_added.delete_invoice_notes_line
    @preq_line_item_added.invoice_notes_line_1.class.should == NilClass
    @preq_line_item_added.invoice_notes_line_counter.should == 0
  end

  it 'should have subline toggle elements' do
    @preq_line_item_added.accounting_lines_toggle.class.should == OLE_QAF::Web_Element
    @preq_line_item_added.invoice_notes_toggle.class.should == OLE_QAF::Web_Element
  end

  it 'should have preq line item fields' do
    @preq_line_item_added.open_quantity_field.class.should == OLE_QAF::Data_Element
    @preq_line_item_added.po_unit_price_field.class.should == OLE_QAF::Data_Element
    @preq_line_item_added.format_field.class.should == OLE_QAF::Data_Element
    @preq_line_item_added.vendor_item_identifier_field.class.should == OLE_QAF::Data_Element
    @preq_line_item_added.prorated_surcharge_field.class.should == OLE_QAF::Data_Element
    @preq_line_item_added.unit_cost_field.class.should == OLE_QAF::Data_Element
    @preq_line_item_added.extended_cost_field.class.should == OLE_QAF::Data_Element
    @preq_line_item_added.assigned_to_trade_in_field.class.should == OLE_QAF::Data_Element
    @preq_line_item_added.description_field.class.should == OLE_QAF::Data_Element
    @preq_line_item_added.number_of_copies_ordered_field.class.should == OLE_QAF::Input_Element
    @preq_line_item_added.number_of_parts_ordered_field.class.should == OLE_QAF::Input_Element
    @preq_line_item_added.list_price_field.class.should == OLE_QAF::Input_Element
    @preq_line_item_added.discount_field.class.should == OLE_QAF::Input_Element
    @preq_line_item_added.discount_type_selector.class.should == OLE_QAF::Selector_Element
  end

end