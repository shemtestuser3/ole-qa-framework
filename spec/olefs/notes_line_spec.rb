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
    @ole = OLE_QAF::Framework.new
    @notes_line = OLE_QAF::OLEFS::Notes_Line.new(@ole.browser, 1, 1)
    @notes_line_added = OLE_QAF::OLEFS::Notes_Line.new(@ole.browser, 1, 1, false)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @notes_line.class.should == OLE_QAF::OLEFS::Notes_Line
  end

  it 'should be a subclass of subline object' do
    @notes_line.class.superclass.should == OLE_QAF::Subline_Object
  end

  it 'should have a path to the YAML files' do
    @notes_line.yaml_path.should == '/olefs/objects/notes_line/'
  end

  it 'should have a browser accessor' do
    @notes_line.browser.class.should == Selenium::WebDriver::Driver
  end

  it 'should have notes line fields' do
    @notes_line.note_type_selector.class.should == OLE_QAF::Selector_Element
    @notes_line.note_field.class.should == OLE_QAF::Input_Element
  end

  it 'should have an add button' do
    @notes_line.add_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have notes line fields' do
    @notes_line_added.note_type_selector.class.should == OLE_QAF::Selector_Element
    @notes_line_added.note_field.class.should == OLE_QAF::Input_Element
  end

  it 'should have a delete button' do
    @notes_line_added.delete_button.class.should == OLE_QAF::Web_Element
  end

end