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

describe 'An OLELS Ownership Extent Line object' do

  before :all do
    @ole = OLE_QA::Framework::Session.new
    @browser = @ole.browser
    @ownership_line = OLE_QA::Framework::OLELS::Ownership_Extent_Line.new(@browser, 1)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @ownership_line.class.should == OLE_QA::Framework::OLELS::Ownership_Extent_Line
    @ownership_line.class.superclass.should == OLE_QA::Framework::OLELS::Line_Object
  end

  it 'should have ownership extent line elements' do
    elements = @ownership_line.methods
    elements.include?(:type_selector).should be_true
    elements.include?(:statement_field).should be_true
    elements.include?(:add_button).should be_true
    elements.include?(:remove_button).should be_true
  end

  it 'should start with one ownership note' do
    @ownership_line.methods.include?(:ownership_note_1).should be_true
    @ownership_line.ownership_note_1.class.should == OLE_QA::Framework::OLELS::Ownership_Note
  end

  it 'should add an ownership note' do
    @ownership_line.add_ownership_note(2)
    @ownership_line.methods.include?(:ownership_note_2).should be_true
    @ownership_line.ownership_note_2.class.should == OLE_QA::Framework::OLELS::Ownership_Note
  end

  it 'should delete an ownership note' do
    @ownership_line.delete_ownership_note(2)
    @ownership_line.methods.include?(:ownership_note_2).should be_false
  end
end