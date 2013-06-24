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
    @ole = OLE_QA::Framework.new
    @rcv = OLE_QA::OLEFS::Receiving_Document.new(@ole)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @rcv.class.should == OLE_QA::OLEFS::Receiving_Document
    @rcv.class.superclass.should == OLE_QA::OLEFS::PURAP_Document
  end

  it 'should open a new receiving document via URL' do
    @rcv.open
    @rcv.title.text.strip.should == "Line Item Receiving"
  end

  it 'should have receiving document elements' do
    elements = @rcv.methods
    elements.include?(:date_received_field).should be_true
    elements.include?(:packing_slip_number_field).should be_true
    elements.include?(:bill_of_lading_number_field).should be_true
    elements.include?(:reference_number_field).should be_true
    elements.include?(:carrier_selector).should be_true
  end

  it 'should have a new receiving line' do
    @rcv.new_receiving_line.class.should == OLE_QA::OLEFS::New_Receiving_Line
  end

  it 'should create a receiving line' do
    @rcv.create_receiving_line(1)
    @rcv.methods.include?(:receiving_line_1).should be_true
    @rcv.receiving_line_1.class.should == OLE_QA::OLEFS::Receiving_Line
  end

  it 'should delete a receiving line' do
    @rcv.remove_receiving_line(1)
    @rcv.methods.include?(:receiving_line_1).should be_false
  end

  it 'should not delete a receiving line which does not exist' do
    lambda {@rcv.remove_receiving_line(1)}.should raise_error
  end
end