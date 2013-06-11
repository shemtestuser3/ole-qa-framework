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
    @ole = OLE_QAF::Framework.new
    @browser = @ole.browser
    @exception_notes_line = OLE_QAF::OLEFS::Exception_Notes_Line.new(@browser, 1, 1)
    @exception_notes_line_added = OLE_QAF::OLEFS::Exception_Notes_Line.new(@browser, 1, 1, new_line = false)
  end

  it 'should create a new instance' do
    @exception_notes_line.class.should == OLE_QAF::OLEFS::Exception_Notes_Line
    @exception_notes_line.class.superclass.should == OLE_QAF::Subline_Object
  end

  it 'should have a path to the YAML files' do
    @exception_notes_line.yaml_path.should == '/olefs/objects/exception_notes_line/'
  end

  it 'should have a browser accessor' do
    @exception_notes_line.browser.class.should == Selenium::WebDriver::Driver
  end

  it 'should have exception notes fields' do
    @exception_notes_line.exception_type_selector.class.should == OLE_QAF::Selector_Element
    @exception_notes_line.note_field.class.should == OLE_QAF::Input_Element
  end

  it 'should have exception notes fields after being added' do
    @exception_notes_line_added.exception_type_selector.class.should == OLE_QAF::Selector_Element
    @exception_notes_line_added.note_field.class.should == OLE_QAF::Input_Element
  end

end