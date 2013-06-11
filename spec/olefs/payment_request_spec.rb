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
    @ole = OLE_QAF::Framework.new
    @browser = @ole.browser
    @preq = OLE_QAF::OLEFS::Payment_Request.new(@browser, @ole.base_url)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @preq.class.should ==  OLE_QAF::OLEFS::Payment_Request
    @preq.class.superclass.should == OLE_QAF::OLEFS::PURAP_Document
  end

  it 'should have invoice info tab elements' do
    @preq.invoice_number_field.class.should == OLE_QAF::Data_Element
    @preq.pay_date_field.class.should == OLE_QAF::Input_Element
    @preq.invoice_date_field.class.should == OLE_QAF::Data_Element
    @preq.immediate_pay_checkbox.class.should == OLE_QAF::Checkbox_Element
    @preq.payment_attachment_checkbox.class.should == OLE_QAF::Checkbox_Element
    @preq.invoice_type_field.class.should == OLE_QAF::Input_Element
    @preq.invoice_subtype_field.class.should == OLE_QAF::Input_Element
    @preq.payment_method_selector.class.should == OLE_QAF::Selector_Element
  end

  it 'should have titles tab elements' do
    @preq.grand_total_field.class.should == OLE_QAF::Data_Element
    @preq.additional_charges_toggle.class.should == OLE_QAF::Web_Element
    @preq.freight_extended_cost_field.class.should == OLE_QAF::Input_Element
    @preq.freight_description_field.class.should == OLE_QAF::Input_Element
    @preq.shipping_handling_extended_cost_field.class.should == OLE_QAF::Input_Element
    @preq.shipping_handling_description_field.class.should == OLE_QAF::Input_Element
    @preq.minimum_order_extended_cost_field.class.should == OLE_QAF::Input_Element
    @preq.minimum_order_description_field.class.should == OLE_QAF::Input_Element
    @preq.miscellaneous_overhead_extended_cost_field.class.should == OLE_QAF::Input_Element
    @preq.miscellaneous_overhead_description_field.class.should == OLE_QAF::Input_Element
    @preq.prorate_by_quantity_checkbox.class.should == OLE_QAF::Checkbox_Element
    @preq.prorate_by_dollar_checkbox.class.should == OLE_QAF::Checkbox_Element
    @preq.prorate_manual_checkbox.class.should == OLE_QAF::Checkbox_Element
    @preq.close_po_checkbox.class.should == OLE_QAF::Checkbox_Element
  end

  it 'should have view related documents tab elements' do
    @preq.view_related_tab_toggle.class.should == OLE_QAF::Web_Element
    @preq.view_related_po_link.class.should == OLE_QAF::Data_Element
    @preq.view_related_requisition_link.class.should == OLE_QAF::Data_Element
  end

  it 'should have a new line item' do
    @preq.new_line_item.class.should == OLE_QAF::OLEFS::PREQ_Line_Item
  end

  it 'should add a line item' do
    @preq.create_line_item
    @preq.line_item_counter.should == 1
    @preq.line_item_1.class.should == OLE_QAF::OLEFS::PREQ_Line_Item
  end

  it 'should remove a line item' do
    @preq.delete_line_item
    @preq.line_item_counter.should == 0
    @preq.line_item_1.class.should == NilClass
  end

end