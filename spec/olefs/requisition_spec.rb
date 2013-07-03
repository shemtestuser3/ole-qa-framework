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
    @ole = OLE_QA::Framework::Session.new
    @req = OLE_QA::Framework::OLEFS::Requisition.new(@ole)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @req.class.should == OLE_QA::Framework::OLEFS::Requisition
  end

  it 'should be a subclass of an OLEFS E-Document' do
    @req.class.superclass.should == OLE_QA::Framework::OLEFS::PURAP_Document
  end

  it 'should open a new purap_requisition via url' do
    @req.open
    @req.title.text.strip.should == "Requisition"
  end

  it 'should have requisition elements' do
    elements = @req.methods
    elements.include?(:license_request_checkbox).should be_true
    elements.include?(:receiving_required_checkbox).should be_true
    elements.include?(:payment_request_approval_required_checkbox).should be_true
    elements.include?(:additional_info_tab_toggle).should be_true
    elements.include?(:additional_info_phone_number_field).should be_true
    elements.include?(:delivery_tab_toggle).should be_true
    elements.include?(:building_field).should be_true
    elements.include?(:campus_field).should be_true
    elements.include?(:room_field).should be_true
    elements.include?(:building_search_icon).should be_true
    elements.include?(:campus_search_icon).should be_true
    elements.include?(:delivery_phone_number_field).should be_true
    elements.include?(:vendor_tab_toggle).should be_true
    elements.include?(:vendor_name_field).should be_true
    elements.include?(:closed_vendor_name_field).should be_true
    elements.include?(:vendor_search_icon).should be_true
    elements.include?(:grand_total_field).should be_true
  end

  it 'should have a new line item' do
    @req.new_line_item.class.should == OLE_QA::Framework::OLEFS::New_Line_Item
  end

  it 'should create a line item' do
    @req.create_line_item(1)
    @req.methods.include?(:line_item_1).should be_true
    @req.line_item_1.class.should == OLE_QA::Framework::OLEFS::Line_Item
  end

  it 'should delete a line item' do
    @req.remove_line_item(1)
    @req.methods.include?(:line_item_1).should be_false
  end

  it 'should not delete a line item which does not exist' do
    lambda {@req.remove_line_item(1)}.should raise_error
  end
end