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

describe 'An OLELS Lookup page' do

  before :all do
    @ole = OLE_QA::Framework::Session.new
    @lookup = OLE_QA::Framework::OLELS::Lookup.new(@ole, @ole.ls_url)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @lookup.class.should == OLE_QA::Framework::OLELS::Lookup
    @lookup.class.superclass.should == OLE_QA::Framework::Page
  end

  it 'should have lookup page elements' do
    elements = @lookup.methods
    elements.include?(:title).should be_true
  end
end