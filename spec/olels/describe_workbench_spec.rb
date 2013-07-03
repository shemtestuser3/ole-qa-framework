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

describe 'An OLELS Describe Workbench page' do

  before :all do
    @ole = OLE_QA::Framework::Session.new
    @workbench = OLE_QA::Framework::OLELS::Describe_Workbench.new(@ole)
  end

  it 'should create a new instance' do
    @workbench.class.should == OLE_QA::Framework::OLELS::Describe_Workbench
    @workbench.class.superclass.should == OLE_QA::Framework::OLELS::Lookup
  end

  it 'should open the describe workbench via URL' do
    @workbench.open
    @workbench.title.text.strip.should == "Describe Workbench"
  end

  it 'should have describe workbench elements' do
    elements = @workbench.methods
    elements.include?(:title).should be_true
    elements.include?(:search_button).should be_true
    elements.include?(:clear_button).should be_true
    elements.include?(:search_field_1).should be_true
    elements.include?(:search_which_selector_1).should be_true
    elements.include?(:search_field_selector_1).should be_true
  end
end