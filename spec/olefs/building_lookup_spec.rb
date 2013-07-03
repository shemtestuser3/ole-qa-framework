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
    @ole = OLE_QA::Framework::Session.new
    @building_lookup = OLE_QA::Framework::OLEFS::Building_Lookup.new(@ole)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @building_lookup.class.should == OLE_QA::Framework::OLEFS::Building_Lookup
    @building_lookup.class.superclass.should == OLE_QA::Framework::OLEFS::Lookup
  end

  it 'should open via URL' do
    @building_lookup.open
    @building_lookup.title.text.strip.should == "Building Lookup"
  end

  it 'should have building lookup elements' do
    methods = @building_lookup.methods
    methods.include?(:campus_code_field).should be_true
    methods.include?(:building_code_field).should be_true
    methods.include?(:building_name_field).should be_true
  end
end