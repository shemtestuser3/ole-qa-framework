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

describe 'A Subline Object' do

  before :all do
    @ole = OLE_QA::Framework::Session.new
    @line_num = 1
    @subline_num = 1
    @subline = OLE_QA::Framework::Subline_Object.new(@ole, @line_num, @subline_num)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @subline.class.should == OLE_QA::Framework::Subline_Object
  end

  it 'should be a subclass of data object' do
    @subline.class.superclass.should == OLE_QA::Framework::Data_Object
  end

  it 'should have a line number' do
    @subline.line_number.should == 1
  end

  it 'should have a line id' do
    @subline.line_id.should == 0
  end

  it 'should have a subline number' do
    @subline.subline_number.should == 1
  end

  it 'should have a subline id' do
    @subline.subline_id.should == 0
  end
end