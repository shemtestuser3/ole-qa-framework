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

describe 'An OLEFS Purchase Order' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @purchase_order = OLE_QAF::OLEFS::Purchase_Order.new(@ole.browser, @ole.base_url)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @purchase_order.class.should == OLE_QAF::OLEFS::Purchase_Order
    @purchase_order.class.superclass.should == OLE_QAF::OLEFS::Requisition
  end

  it 'should have Purchase Order Detail elements' do
    @purchase_order.funding_source_selector.class.should == OLE_QAF::Selector_Element
  end

  it 'should have Vendor elements' do
    @purchase_order.vendor_name_field.class.should == OLE_QAF::Data_Element
  end

  it 'should have View Related Docs elements' do
    @purchase_order.view_related_requisition_link.class.should == OLE_QAF::Data_Element
  end

  it 'should have Input Button elements' do
    @purchase_order.sensitive_data_button.class.should == OLE_QAF::Web_Element
    @purchase_order.payment_hold_button.class.should == OLE_QAF::Web_Element
    @purchase_order.amend_button.class.should == OLE_QAF::Web_Element
    @purchase_order.void_order_button.class.should == OLE_QAF::Web_Element
    @purchase_order.receiving_button.class.should == OLE_QAF::Web_Element
    @purchase_order.print_button.class.should == OLE_QAF::Web_Element
    @purchase_order.send_ad_hoc_button.class.should == OLE_QAF::Web_Element
  end

end