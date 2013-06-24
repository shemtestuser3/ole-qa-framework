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

describe 'A notes line' do

  before :all do
    @ole = OLE_QA::Framework.new
    @notes_line = OLE_QA::OLEFS::Notes_Line.new(@ole, 1, 1)
    @new_notes_line = OLE_QA::OLEFS::New_Notes_Line.new(@ole, 1, 0)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @notes_line.class.should == OLE_QA::OLEFS::Notes_Line
    @new_notes_line.class.should == OLE_QA::OLEFS::New_Notes_Line
  end

  it 'should be a subclass of subline object' do
    @notes_line.class.superclass.should == OLE_QA::Subline_Object
    @new_notes_line.class.superclass.should == OLE_QA::Subline_Object
  end

  it 'should have a browser accessor' do
    @notes_line.browser.class.should == @ole.browser.class
    @new_notes_line.browser.class.should == @ole.browser.class
  end

  it 'should have line number attributes' do
    @notes_line.line_number.should == 1
    @notes_line.subline_number.should == 1
  end

  it 'should have notes line elements' do
    methods_array = @notes_line.methods
    methods_array.include?(:note_type_selector).should be_true
    methods_array.include?(:note_field).should be_true
    methods_array.include?(:delete_button).should be_true
    methods_array.include?(:closed_note_type_field).should be_true
    methods_array.include?(:closed_note_field).should be_true
  end

  it 'should have new notes line elements' do
    elements = @new_notes_line.methods
    elements.include?(:note_type_selector).should be_true
    elements.include?(:note_field).should be_true
    elements.include?(:add_button).should be_true
  end
end