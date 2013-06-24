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

describe 'An OLEFS Lookup page' do

  before :all do
    @ole = OLE_QA::Framework.new
    @lookup = OLE_QA::OLEFS::Lookup.new(@ole, @ole.base_url)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @lookup.class.should == OLE_QA::OLEFS::Lookup
    @lookup.class.superclass.should == OLE_QA::Page
  end

  it 'should have lookup page screen elements' do
    methods = @lookup.methods
    methods.include?(:title).should be_true
    methods.include?(:active_indicator_yes).should be_true
    methods.include?(:active_indicator_no).should be_true
    methods.include?(:active_indicator_both).should be_true
    methods.include?(:search_button).should be_true
    methods.include?(:clear_button).should be_true
    methods.include?(:cancel_button).should be_true
  end
end