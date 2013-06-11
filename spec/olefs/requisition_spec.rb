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


describe 'A purap_requisition document' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @req = OLE_QAF::OLEFS::Requisition.new(@ole.browser, @ole.base_url)
    @web_name = "OLE_QAF::Web_Element"
    @data_name = "OLE_QAF::Data_Element"
    @input_name = "OLE_QAF::Input_Element"
    @array_name = "OLE_QAF::Web_Element_Array"
    @select_name = "OLE_QAF::Selector_Element"
    @checkbox_name = "OLE_QAF::Checkbox_Element"
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @req.class.should == OLE_QAF::OLEFS::Requisition
  end

  it 'should be a subclass of an OLEFS E-Document' do
    @req.class.superclass.should == OLE_QAF::OLEFS::PURAP_Document
  end

  it 'should open a new purap_requisition via url' do
    @req.open
    @req.title.verify_text("Requisition").should be_true
  end

  it 'should have Document Overview elements' do
    @req.description_field.class.name.should == @input_name
    @req.explanation_field.class.name.should == @input_name
  end

  it 'should have Requisition Detail elements' do
    @req.license_request_checkbox.class.name.should == @checkbox_name
    @req.receiving_required_checkbox.class.name.should == @checkbox_name
    @req.payment_request_approval_required_checkbox.class.name.should == @checkbox_name
  end

  it 'should have Additional Information elements' do
    @req.additional_info_tab_toggle.class.name.should == @web_name
    @req.phone_number_field.class.name.should == @input_name
  end

  it 'should have Delivery elements' do
    @req.delivery_tab_toggle.class.name.should == @web_name
    @req.building_field.class.name.should == @input_name
    @req.room_field.class.name.should == @input_name
    @req.building_search_icon.class.name.should == @web_name
    @req.campus_search_icon.class.name.should == @web_name
  end

  it 'should have Vendor elements' do
    @req.vendor_tab_toggle.class.name.should == @web_name
    @req.vendor_name_field.class.name.should == @input_name
    @req.vendor_name_added_field.class.name.should == @data_name
    @req.vendor_search_icon.class.name.should == @web_name
  end

  it 'should have Titles elements' do
    @req.grand_total_field.class.name.should == @data_name
  end

  it 'should have Related Doc elements' do
    @req.view_related_tab_toggle.class.name.should == @web_name
    @req.view_related_po_link.class.name.should == @data_name
  end

  it 'should start out with one line item' do
    @req.new_line_item.class.should == OLE_QAF::OLEFS::Line_Item
    @req.line_item_counter.should == 0
  end

  it 'should create a new line item' do
    @req.create_line_item
    @req.line_item_1.class.should == OLE_QAF::OLEFS::Line_Item
    @req.line_item_counter.should == 1
  end

  it 'should delete a line item' do
    @req.delete_line_item
    @req.line_item_1.class.should == NilClass
    @req.line_item_counter.should == 0
  end

end