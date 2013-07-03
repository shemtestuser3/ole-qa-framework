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

describe 'An OLEFS Exception Notes Line object' do

  before :all do
    @ole = OLE_QA::Framework::Session.new
    @browser = @ole.browser
    @exception_notes_line = OLE_QA::Framework::OLEFS::Exception_Notes_Line.new(@ole, 1, 1)
    @new_exception_notes_line = OLE_QA::Framework::OLEFS::New_Exception_Notes_Line.new(@ole, 1, 0)
  end

  it 'should create a new instance' do
    @exception_notes_line.class.should == OLE_QA::Framework::OLEFS::Exception_Notes_Line
    @exception_notes_line.class.superclass.should == OLE_QA::Framework::Subline_Object
    @new_exception_notes_line.class.should == OLE_QA::Framework::OLEFS::New_Exception_Notes_Line
    @new_exception_notes_line.class.superclass.should == OLE_QA::Framework::Subline_Object
  end

  it 'should have a browser accessor' do
    @exception_notes_line.browser.class.should == @ole.browser.class
    @new_exception_notes_line.browser.class.should == @ole.browser.class
  end

  it 'should have exception notes elements' do
    methods = @exception_notes_line.methods
    methods.include?(:exception_type_selector).should be_true
    methods.include?(:note_field).should be_true
    methods.include?(:note_type_selector).should be_true
  end

  it 'should have new exception notes elements' do
    elements = @new_exception_notes_line.methods
    elements.include?(:exception_type_selector).should be_true
    elements.include?(:note_field).should be_true
    elements.include?(:note_type_selector).should be_true
  end
end