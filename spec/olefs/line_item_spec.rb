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
    @ole = OLE_QAF::Framework.new
    @browser = @ole.browser
    @line_number = 1
    @line_item = OLE_QAF::OLEFS::Line_Item.new(@browser, @line_number)
    @line_item_added = OLE_QAF::OLEFS::Line_Item.new(@browser, @line_number, new_line = false)
  end

  it 'should should create a new instance' do
    @line_item.class.should == OLE_QAF::OLEFS::Line_Item
  end

  it 'should have an appropriate YAML path' do
    @line_item.yaml_path.should == '/olefs/objects/line_item/'
  end

  it 'should be a subclass of Line Object' do
    @line_item.class.superclass.should == OLE_QAF::Line_Object
  end

  it 'should have a browser accessor' do
    @line_item.browser.class.should == Selenium::WebDriver::Driver
  end

  it 'should have a line number of 1' do
    @line_item.line_number.should == 1
  end

  it 'should have a line identifier of 0' do
    @line_item.line_identifier.should == 0
  end

  it 'should have an add button' do
    @line_item.add_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have a new bib button' do
    @line_item.new_bib_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have an import lines button' do
    @line_item.import_lines.class.should == OLE_QAF::Web_Element
  end

  it 'should have a number of copies field' do
    @line_item.number_of_copies_field.class.should == OLE_QAF::Input_Element
  end

  it 'should have a number of parts field' do
    @line_item.number_of_parts_field.class.should == OLE_QAF::Input_Element
  end

  it 'should have a list price field' do
    @line_item.list_price_field.class.should == OLE_QAF::Input_Element
  end

  it 'should have a discount field' do
    @line_item.discount_field.class.should == OLE_QAF::Input_Element
  end

  it 'should have an item price source selector' do
    @line_item.item_price_source_selector.class.should == OLE_QAF::Selector_Element
  end

  it 'should have a request source selector' do
    @line_item.request_source_selector.class.should == OLE_QAF::Selector_Element
  end

  it 'should have an item type selector' do
    @line_item.item_type_selector.class.should == OLE_QAF::Selector_Element
  end

  it 'should have a format selector' do
    @line_item.format_selector.class.should == OLE_QAF::Selector_Element
  end

  it 'should have a category selector' do
    @line_item.category_selector.class.should == OLE_QAF::Selector_Element
  end

  it 'should have a discount type selector' do
    @line_item.discount_type_selector.class.should == OLE_QAF::Selector_Element
  end

  it 'should have a public view checkbox' do
    @line_item.public_view_checkbox.class.should == OLE_QAF::Checkbox_Element
  end

  it 'should have a route to requestor checkbox' do
    @line_item.route_to_requestor_checkbox.class.should == OLE_QAF::Checkbox_Element
  end

  it 'should have a requestor ID data element' do
    @line_item.requestor_id.class.should == OLE_QAF::Data_Element
  end

  it 'should have an extended cost data element' do
    @line_item.extended_cost.class.should == OLE_QAF::Data_Element
  end

  it 'should have a unit cost data element' do
    @line_item.unit_cost.class.should == OLE_QAF::Data_Element
  end

  it 'should not have an add button after being added' do
    lambda {@line_item_added.add_button}.should raise_error
  end

  it 'should have a delete button after being added' do
    @line_item_added.delete_button.class.should == OLE_QAF::Web_Element
    @line_item_added.delete_button.what.should == "input[title=\"Delete Item 1\"]"
  end

  it 'should have a link to the current bib record after being added' do
    @line_item_added.current_bib.class.should == OLE_QAF::Data_Element
  end
 
  it 'should have a number of copies field' do
    @line_item_added.number_of_copies_field.class.should == OLE_QAF::Input_Element
  end

  it 'should have a number of parts field' do
    @line_item_added.number_of_parts_field.class.should == OLE_QAF::Input_Element
  end

  it 'should have a list price field' do
    @line_item_added.list_price_field.class.should == OLE_QAF::Input_Element
  end

  it 'should have a discount field' do
    @line_item_added.discount_field.class.should == OLE_QAF::Input_Element
  end

  it 'should have an item price source selector' do
    @line_item_added.item_price_source_selector.class.should == OLE_QAF::Selector_Element
  end

  it 'should have a request source selector' do
    @line_item_added.request_source_selector.class.should == OLE_QAF::Selector_Element
  end

  it 'should have an item type selector' do
    @line_item_added.item_type_selector.class.should == OLE_QAF::Selector_Element
  end

  it 'should have a format selector' do
    @line_item_added.format_selector.class.should == OLE_QAF::Selector_Element
  end

  it 'should have a category selector' do
    @line_item_added.category_selector.class.should == OLE_QAF::Selector_Element
  end

  it 'should have a discount type selector' do
    @line_item_added.discount_type_selector.class.should == OLE_QAF::Selector_Element
  end

  it 'should have a public view checkbox' do
    @line_item_added.public_view_checkbox.class.should == OLE_QAF::Checkbox_Element
  end

  it 'should have a route to requestor checkbox' do
    @line_item_added.route_to_requestor_checkbox.class.should == OLE_QAF::Checkbox_Element
  end

  it 'should have a requestor ID data element' do
    @line_item_added.requestor_id.class.should == OLE_QAF::Data_Element
  end

  it 'should have an extended cost data element' do
    @line_item_added.extended_cost.class.should == OLE_QAF::Data_Element
  end

  it 'should have a unit cost data element' do
    @line_item_added.unit_cost.class.should == OLE_QAF::Data_Element
  end

  it 'should have a notes tab toggle' do
    @line_item_added.notes_toggle.class.should == OLE_QAF::Web_Element
  end

  it 'should have an accounting lines tab toggle' do
    @line_item_added.accounting_lines_toggle.class.should == OLE_QAF::Web_Element
  end

  it 'should have a copies tab toggle' do
    @line_item_added.copies_toggle.class.should == OLE_QAF::Web_Element
  end

  it 'should have a new accounting line' do
    @line_item_added.new_accounting_line.class.should == OLE_QAF::OLEFS::Accounting_Line
    @line_item_added.accounting_line_counter.should == 0
  end

  it 'should create an accounting line' do
    @line_item_added.create_accounting_line
    @line_item_added.accounting_line_counter.should == 1
    @line_item_added.accounting_line_1.class.should == OLE_QAF::OLEFS::Accounting_Line
  end

  it 'should delete an accounting line' do
    @line_item_added.delete_accounting_line
    @line_item_added.accounting_line_1.class.should == NilClass
    @line_item_added.accounting_line_counter.should == 0
  end

  it 'should raise an error when asked to delete an accounting line that does not exist' do
    lambda {@line_item_added.delete_accounting_line}.should raise_error
  end

  it 'should have a new copies line' do
    @line_item_added.new_copies_line.class.should == OLE_QAF::OLEFS::Copies_Line
    @line_item_added.copies_line_counter.should == 0
  end

  it 'should create a copies line' do
    @line_item_added.create_copies_line
    @line_item_added.copies_line_counter.should == 1
    @line_item_added.copies_line_1.class.should == OLE_QAF::OLEFS::Copies_Line
  end

  it 'should delete a copies line' do
    @line_item_added.delete_copies_line
    @line_item_added.copies_line_1.class.should == NilClass
    @line_item_added.copies_line_counter.should == 0
  end

  it 'should raise an error when asked to delete a copies line that does not exist' do
    lambda {@line_item_added.delete_copies_line}.should raise_error
  end

  it 'should have a new notes line' do
    @line_item_added.new_notes_line.class.should == OLE_QAF::OLEFS::Notes_Line
    @line_item_added.notes_line_counter.should == 0
  end

  it 'should create a notes line' do
    @line_item_added.create_notes_line
    @line_item_added.notes_line_counter.should == 1
    @line_item_added.notes_line_1.class.should == OLE_QAF::OLEFS::Notes_Line
  end

  it 'should delete a notes line' do
    @line_item_added.delete_notes_line
    @line_item_added.notes_line_counter.should == 0
    @line_item_added.notes_line_1.class.should == NilClass
  end

  it 'should raise an error when asked to delete a notes line that does not exist' do
    lambda {@line_item_added.delete_notes_line}.should raise_error
  end
end