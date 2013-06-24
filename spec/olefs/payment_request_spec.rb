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

describe 'An OLEFS Payment Request page' do

  before :all do
    @ole = OLE_QA::Framework.new
    @browser = @ole.browser
    @preq = OLE_QA::OLEFS::Payment_Request.new(@ole)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @preq.class.should ==  OLE_QA::OLEFS::Payment_Request
    @preq.class.superclass.should == OLE_QA::OLEFS::PURAP_Document
  end

  it 'should open a new PREQ document via URL' do
    @preq.open
    @preq.title.text.strip.should == "Payment Request"
  end

  it 'should have payment request elements' do
    elements = @preq.methods
    elements.include?(:invoice_number_field).should be_true
    elements.include?(:pay_date_field).should be_true
    elements.include?(:invoice_date_field).should be_true
    elements.include?(:immediate_pay_checkbox).should be_true
    elements.include?(:payment_attachment_checkbox).should be_true
    elements.include?(:invoice_type_field).should be_true
    elements.include?(:invoice_subtype_field).should be_true
    elements.include?(:payment_method_selector).should be_true
    elements.include?(:grand_total_field).should be_true
    elements.include?(:additional_charges_toggle).should be_true
    elements.include?(:freight_extended_cost_field).should be_true
    elements.include?(:freight_description_field).should be_true
    elements.include?(:shipping_handling_extended_cost_field).should be_true
    elements.include?(:shipping_handling_description_field).should be_true
    elements.include?(:minimum_order_extended_cost_field).should be_true
    elements.include?(:minimum_order_description_field).should be_true
    elements.include?(:misc_overhead_extended_cost_field).should be_true
    elements.include?(:misc_overhead_description_field).should be_true
    elements.include?(:prorate_by_quantity_checkbox).should be_true
    elements.include?(:prorate_by_dollar_checkbox).should be_true
    elements.include?(:prorate_manual_checkbox).should be_true
    elements.include?(:close_po_checkbox).should be_true
  end

  it 'should have a new line item' do
    @preq.methods.include?(:new_line_item).should be_true
    @preq.new_line_item.class.should == OLE_QA::OLEFS::New_PREQ_Line_Item
  end

  it 'should create a line item' do
    @preq.create_line_item(1)
    @preq.methods.include?(:line_item_1).should be_true
    @preq.line_item_1.class.should == OLE_QA::OLEFS::PREQ_Line_Item
  end

  it 'should remove a line item' do
    @preq.remove_line_item(1)
    @preq.methods.include?(:line_item_1).should be_false
  end

  it 'should raise an error when asked to remove a line item which does not exist' do
    lambda {@preq.remove_line_item(1)}.should raise_error
  end
end