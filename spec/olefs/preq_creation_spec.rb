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

describe 'An OLEFS Payment Request Creation page' do

  before :all do
    @ole = OLE_QA::Framework::Session.new
    @preq_screen = OLE_QA::Framework::OLEFS::PREQ_Creation.new(@ole)
  end

  it 'should create a new instance' do
    @preq_screen.class.should == OLE_QA::Framework::OLEFS::PREQ_Creation
    @preq_screen.class.superclass.should == OLE_QA::Framework::OLEFS::E_Doc
  end

  it 'should have PREQ creation screen elements' do
    elements = @preq_screen.methods
    elements.include?(:purchase_order_number_field).should be_true
    elements.include?(:invoice_number_field).should be_true
    elements.include?(:invoice_date_field).should be_true
    elements.include?(:invoice_amount_field).should be_true
    elements.include?(:special_handling_line_1).should be_true
    elements.include?(:special_handling_line_2).should be_true
    elements.include?(:special_handling_line_3).should be_true
    elements.include?(:foreign_invoice_amount_field).should be_true
    elements.include?(:continue_button).should be_true
    elements.include?(:clear_button).should be_true
  end
end