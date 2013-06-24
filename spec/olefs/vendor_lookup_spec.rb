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

describe 'An OLEFS Vendor Lookup page' do

  before :all do
    @ole = OLE_QA::Framework.new
    @vendor_lookup = OLE_QA::OLEFS::Vendor_Lookup.new(@ole)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @vendor_lookup.class.should == OLE_QA::OLEFS::Vendor_Lookup
    @vendor_lookup.class.superclass.should == OLE_QA::OLEFS::Lookup
  end

  it 'should open via URL' do
    @vendor_lookup.open
    @vendor_lookup.title.text.strip.should == "Vendor Lookup"
  end

  it 'should have vendor lookup elements' do
    methods = @vendor_lookup.methods
    methods.include?(:vendor_name_field).should be_true
    methods.include?(:tax_number_field).should be_true
    methods.include?(:vendor_number_field).should be_true
    methods.include?(:vendor_type_selector).should be_true
    methods.include?(:state_field).should be_true
    methods.include?(:commodity_code_field).should be_true
    methods.include?(:supplier_diversity_selector).should be_true
  end
end