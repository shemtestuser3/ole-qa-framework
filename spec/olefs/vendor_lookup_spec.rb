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
    @ole = OLE_QAF::Framework.new
    @vendor_lookup = OLE_QAF::OLEFS::Vendor_Lookup.new(@ole.browser, @ole.base_url)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @vendor_lookup.class.should == OLE_QAF::OLEFS::Vendor_Lookup
    @vendor_lookup.class.superclass.should == OLE_QAF::OLEFS::Lookup
  end

  it 'should open via URL' do
    @vendor_lookup.open
    @vendor_lookup.title.verify_text("Vendor Lookup")
  end

  it 'should have vendor lookup elements' do
    @vendor_lookup.vendor_name_field.class.should == OLE_QAF::Input_Element
    @vendor_lookup.tax_number_field.class.should == OLE_QAF::Input_Element
    @vendor_lookup.vendor_number_field.class.should == OLE_QAF::Input_Element
    @vendor_lookup.vendor_type_selector.class.should == OLE_QAF::Selector_Element
    @vendor_lookup.state_field.class.should == OLE_QAF::Input_Element
    @vendor_lookup.commodity_code_field.class.should == OLE_QAF::Input_Element
    @vendor_lookup.supplier_diversity_selector.class.should == OLE_QAF::Selector_Element
  end
end