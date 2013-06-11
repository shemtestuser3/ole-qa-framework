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

describe 'An OLELS Item Editor page' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @browser = @ole.browser
    @item_editor = OLE_QAF::OLELS::Item_Editor.new(@browser, @ole.ls_url)
  end

  it 'should create a new instance' do
    @item_editor.class.should == OLE_QAF::OLELS::Item_Editor
    @item_editor.class.superclass.should == OLE_QAF::OLELS::Editor
  end

  it 'should have holdings location elements' do
    @item_editor.holdings_prefix_field.class.should == OLE_QAF::Data_Element
    @item_editor.holdings_shelving_order_field.class.should == OLE_QAF::Data_Element
    @item_editor.holdings_call_number_field.class.should == OLE_QAF::Data_Element
    @item_editor.holdings_call_number_type_field.class.should == OLE_QAF::Data_Element
  end

  it 'should have item location elements' do
    @item_editor.location_field.class.should == OLE_QAF::Input_Element
    @item_editor.prefix_field.class.should == OLE_QAF::Input_Element
    @item_editor.shelving_order_field.class.should == OLE_QAF::Input_Element
    @item_editor.call_number_field.class.should == OLE_QAF::Input_Element
    @item_editor.call_number_type_selector.class.should == OLE_QAF::Selector_Element
    @item_editor.browse_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have item information elements' do
    @item_editor.item_id_field.class.should == OLE_QAF::Data_Element
    @item_editor.barcode_field.class.should == OLE_QAF::Input_Element
    @item_editor.barcode_arsl_field.class.should == OLE_QAF::Input_Element
    @item_editor.former_identifiers_field.class.should == OLE_QAF::Input_Element
    @item_editor.statistical_searching_codes_selector.class.should == OLE_QAF::Selector_Element
    @item_editor.temp_item_type_selector.class.should == OLE_QAF::Selector_Element
    @item_editor.enumeration_field.class.should == OLE_QAF::Input_Element
    @item_editor.chronology_field.class.should == OLE_QAF::Input_Element
    @item_editor.copy_number_field.class.should == OLE_QAF::Input_Element
    @item_editor.access_info_uri_field.class.should == OLE_QAF::Input_Element
    @item_editor.item_type_selector.class.should == OLE_QAF::Selector_Element
    @item_editor.number_of_pieces_field.class.should == OLE_QAF::Input_Element
  end

  it 'should have acquisition information elements' do
    @item_editor.po_line_item_id_field.class.should == OLE_QAF::Data_Element
    @item_editor.vendor_line_item_id_field.class.should == OLE_QAF::Data_Element
    @item_editor.fund_field.class.should == OLE_QAF::Data_Element
    @item_editor.price_field.class.should == OLE_QAF::Input_Element
    @item_editor.donor_public_display_field.class.should == OLE_QAF::Input_Element
    @item_editor.donor_note_field.class.should == OLE_QAF::Input_Element
  end

  it 'should have circulation information elements' do
    @item_editor.item_status_selector.class.should == OLE_QAF::Selector_Element
    @item_editor.checkin_note_field.class.should == OLE_QAF::Input_Element
    @item_editor.fast_add_checkbox.class.should == OLE_QAF::Checkbox_Element
    @item_editor.staff_only_checkbox.class.should == OLE_QAF::Checkbox_Element
  end

  it 'should have extended information elements' do
    @item_editor.high_density_storage_field.class.should == OLE_QAF::Input_Element
  end

  it 'should have an item note' do
    @item_editor.item_note_counter.should == 1
    @item_editor.item_note_1.class.should == OLE_QAF::OLELS::Editor_Note
  end

  it 'should add an item note' do
    @item_editor.add_item_note(false)
    @item_editor.item_note_2.class.should == OLE_QAF::OLELS::Editor_Note
    @item_editor.item_note_counter.should == 2
  end

  it 'should delete an item note' do
    @item_editor.delete_item_note(2, false)
    @item_editor.item_note_2.class.should == NilClass
    @item_editor.item_note_counter.should == 1
  end
end