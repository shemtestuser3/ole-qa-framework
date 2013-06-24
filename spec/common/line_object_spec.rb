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


describe 'A Line Object' do

  before :all do
    @ole = OLE_QA::Framework.new
    @line_object = OLE_QA::Line_Object.new(@ole, 1)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @line_object.class.should == OLE_QA::Line_Object
  end

  it 'should be a subclass of data object' do
    @line_object.class.superclass.should == OLE_QA::Data_Object
  end

  it 'should have a browser accessor' do
    @line_object.browser.class.should == @ole.browser.class
  end

  it 'should have a line number' do
    @line_object.line_number.should == 1
  end

  it 'should have a line id' do
    @line_object.line_id.should == 0
  end
end