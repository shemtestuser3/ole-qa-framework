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

describe 'An OLEFS Building Lookup page' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @building_lookup = OLE_QAF::OLEFS::Building_Lookup.new(@ole.browser, @ole.base_url)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @building_lookup.class.should == OLE_QAF::OLEFS::Building_Lookup
    @building_lookup.class.superclass.should == OLE_QAF::OLEFS::Lookup
  end

  it 'should open via URL' do
    @building_lookup.open
    @building_lookup.title.verify_text("Building Lookup")
  end

  it 'should have building lookup elements' do
    @building_lookup.campus_code_field.class.should == OLE_QAF::Input_Element
    @building_lookup.building_code_field.class.should == OLE_QAF::Input_Element
    @building_lookup.building_name_field.class.should == OLE_QAF::Input_Element
  end
end