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

describe 'A copies line' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @copies_line = OLE_QAF::OLEFS::Copies_Line.new(@ole.browser, 1, 1)
    @copies_line_added = OLE_QAF::OLEFS::Copies_Line.new(@ole.browser, 1, 1, new_line = false)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @copies_line.class.should == OLE_QAF::OLEFS::Copies_Line
  end

  it 'should be a subclass of subline object' do
    @copies_line.class.superclass.should == OLE_QAF::Subline_Object
  end

  it 'should have a path to the YAML files' do
    @copies_line.yaml_path.should == '/olefs/objects/copies_line/'
  end

  it 'should have a browser accessor' do
    @copies_line.browser.class.should == Selenium::WebDriver::Driver
  end

  it 'should have copies line fields' do
    @copies_line.copies_field.class.should == OLE_QAF::Input_Element
    @copies_line.location_copies_selector.class.should == OLE_QAF::Selector_Element
    @copies_line.starting_copy_field.class.should == OLE_QAF::Input_Element
  end

  it 'should have an add button' do
    @copies_line.add_button.class.should == OLE_QAF::Web_Element
  end

   it 'should have copies line fields' do
    @copies_line_added.copies_field.class.should == OLE_QAF::Data_Element
    @copies_line_added.location_copies_selector.class.should == OLE_QAF::Selector_Element
    @copies_line_added.starting_copy_field.class.should == OLE_QAF::Data_Element
    @copies_line_added.parts_field.class.should == OLE_QAF::Data_Element
    @copies_line_added.part_enumeration_field.class.should == OLE_QAF::Data_Element
  end

  it 'should have a delete button' do
    @copies_line_added.delete_button.class.should == OLE_QAF::Web_Element
  end

end