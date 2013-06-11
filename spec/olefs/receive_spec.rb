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

describe 'An OLEFS Receiving Document page' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @rcv = OLE_QAF::OLEFS::Receiving_Document.new(@ole.browser, @ole.base_url)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @rcv.class.should == OLE_QAF::OLEFS::Receiving_Document
    @rcv.class.superclass.should == OLE_QAF::OLEFS::PURAP_Document
  end

  it 'should have vendor tab fields' do
    @rcv.vendor_tab_toggle.class.should == OLE_QAF::Web_Element
    @rcv.date_received_field.class.should == OLE_QAF::Input_Element
    @rcv.packing_slip_number_field.class.should == OLE_QAF::Input_Element
    @rcv.bill_of_lading_number_field.class.should == OLE_QAF::Input_Element
    @rcv.reference_number_field.class.should == OLE_QAF::Input_Element
    @rcv.carrier_selector.class.should == OLE_QAF::Selector_Element
  end

  it 'should have delivery tab fields' do
    @rcv.delivery_tab_toggle.class.should == OLE_QAF::Web_Element
    @rcv.campus_field.class.should == OLE_QAF::Data_Element
    @rcv.building_field.class.should == OLE_QAF::Data_Element
    @rcv.address_field.class.should == OLE_QAF::Data_Element
    @rcv.room_field.class.should == OLE_QAF::Data_Element
    @rcv.city_field.class.should == OLE_QAF::Data_Element
    @rcv.state_field.class.should == OLE_QAF::Data_Element
    @rcv.postal_code_field.class.should == OLE_QAF::Data_Element
    @rcv.country_field.class.should == OLE_QAF::Data_Element
    @rcv.delivery_to_field.class.should == OLE_QAF::Data_Element
    @rcv.phone_number_field.class.should == OLE_QAF::Data_Element
    @rcv.email_field.class.should == OLE_QAF::Data_Element
  end

  it 'should have related documents tab fields' do
    @rcv.view_related_tab_toggle.class.should == OLE_QAF::Web_Element
    @rcv.view_related_po_link.class.should == OLE_QAF::Data_Element
    @rcv.view_related_requisition_link.class.should == OLE_QAF::Data_Element
  end

  it 'should have a new receiving line' do
    @rcv.new_receiving_line.class.should == OLE_QAF::OLEFS::Receiving_Line
    @rcv.receiving_line_counter.should == 0
  end

  it 'should add a receiving line' do
    @rcv.create_receiving_line
    @rcv.receiving_line_counter.should == 1
    @rcv.receiving_line_1.class.should == OLE_QAF::OLEFS::Receiving_Line
  end

  it 'should remove a receiving line' do
    @rcv.delete_receiving_line
    @rcv.receiving_line_counter.should == 0
    @rcv.receiving_line_1.class.should == NilClass
  end

  it 'should return an error when asked to remove a non-existent receiving line' do
    lambda {@rcv.remove_receiving_line}.should raise_error
  end
end