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
    @ole = OLE_QAF::Framework.new
    @browser = @ole.browser
    @ownership_line = OLE_QAF::OLELS::Ownership_Extent_Line.new(@browser, 1)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @ownership_line.class.should == OLE_QAF::OLELS::Ownership_Extent_Line
    @ownership_line.class.superclass.should == OLE_QAF::Data_Object
  end

  it 'should have ownership extent fields' do
    @ownership_line.type_selector.class.should == OLE_QAF::Selector_Element
    @ownership_line.statement_field.class.should == OLE_QAF::Input_Element
    @ownership_line.add_button.class.should == OLE_QAF::Web_Element
    @ownership_line.remove_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have an ownership note line' do
    @ownership_line.ownership_note_1.class.should == OLE_QAF::OLELS::Editor_Note
  end

  it 'should add an ownership note line' do
    @ownership_line.add_ownership_note(do_click = false)
    @ownership_line.ownership_note_2.class.should == OLE_QAF::OLELS::Editor_Note
    @ownership_line.ownership_notes_counter.should == 2
  end

  it 'should delete an ownership note line' do
    @ownership_line.delete_ownership_note(2, do_click = false)
    @ownership_line.ownership_note_2.class.should == NilClass
    @ownership_line.ownership_notes_counter.should == 1
  end
end