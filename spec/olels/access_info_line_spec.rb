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

describe 'An OLELS Access Info Line object' do

  before :all do
    @ole = OLE_QA::Framework::Session.new
    @access_info = OLE_QA::Framework::OLELS::Access_Info_Line.new(@ole,1)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @access_info.class.should == OLE_QA::Framework::OLELS::Access_Info_Line
    @access_info.class.superclass.should == OLE_QA::Framework::OLELS::Line_Object
  end

  it 'should have access info elements' do
    elements = @access_info.methods
    elements.include?(:access_info_field).should be_true
    elements.include?(:add_button).should be_true
    elements.include?(:remove_button).should be_true
  end
end