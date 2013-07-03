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

describe 'An OLEFS Receipt Notes Line object' do

  before :all do
    @ole = OLE_QA::Framework::Session.new
    @browser = @ole.browser
    @receipt_notes_line = OLE_QA::Framework::OLEFS::Receipt_Notes_Line.new(@ole, 1, 1)
    @new_receipt_notes_line = OLE_QA::Framework::OLEFS::New_Receipt_Notes_Line.new(@ole, 1, 0)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @receipt_notes_line.class.should == OLE_QA::Framework::OLEFS::Receipt_Notes_Line
    @receipt_notes_line.class.superclass.should == OLE_QA::Framework::Subline_Object
    @new_receipt_notes_line.class.should == OLE_QA::Framework::OLEFS::New_Receipt_Notes_Line
    @new_receipt_notes_line.class.superclass.should == OLE_QA::Framework::Subline_Object
  end

  it 'should have a browser accessor' do
    @receipt_notes_line.browser.class.should == @ole.browser.class
    @new_receipt_notes_line.browser.class.should == @ole.browser.class
  end

  it 'should have receipt notes elements' do
    methods = @receipt_notes_line.methods
    methods.include?(:note_type_selector).should be_true
    methods.include?(:note_field).should be_true
  end

  it 'should have new receipt notes elements' do
    methods = @new_receipt_notes_line.methods
    methods.include?(:note_type_selector).should be_true
    methods.include?(:note_field).should be_true
  end
end