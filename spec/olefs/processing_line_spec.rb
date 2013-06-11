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

describe 'An OLEFS Processing Line object' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @browser = @ole.browser
    @processing_line = OLE_QAF::OLEFS::Processing_Line.new(@browser, 1, 1)
    @processing_line_added = OLE_QAF::OLEFS::Processing_Line.new(@browser, 1, 1, false)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @processing_line.class.should == OLE_QAF::OLEFS::Processing_Line
    @processing_line.class.superclass.should == OLE_QAF::Subline_Object
  end

  it 'should have a path to the YAML files' do
    @processing_line.yaml_path.should == '/olefs/objects/processing_line/'
  end

  it 'should have a browser accessor' do
    @processing_line.browser.class.should == Selenium::WebDriver::Driver
  end

  it 'should have processing line fields' do
    @processing_line.note_field.class.should == OLE_QAF::Data_Element
    @processing_line.acknowledge_checkbox.class.should == OLE_QAF::Checkbox_Element
  end

  it 'should have the same elements after being added' do
    @processing_line_added.note_field.class.should == OLE_QAF::Data_Element
    @processing_line_added.acknowledge_checkbox.class.should == OLE_QAF::Checkbox_Element
  end

end