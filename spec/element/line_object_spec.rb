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


describe 'A Line Object' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @yaml_path = "/common/line_object/"
    @line_object = OLE_QAF::Line_Object.new(@ole.browser, @yaml_path, 1)
    @line_object_added = OLE_QAF::Line_Object.new(@ole.browser, @yaml_path, 1, new_line = false)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @line_object.class.should == OLE_QAF::Line_Object
  end

  it 'should have a YAML file path' do
    @line_object.yaml_path.should == @yaml_path
  end

  it 'should have a line number' do
    @line_object.line_number.should == 1
  end

  it 'should have a line identifier' do
    @line_object.line_identifier.should == 0
  end

  it 'should create a line element' do
    @line_object.fake_element.class.should == OLE_QAF::Web_Element
  end

  it 'should replace LINENUM in an identifier string with 1 on a new element' do
    @line_object.plugh.what.should == "item_1"
  end

  it 'should replace LINEID in an identifier string with 0 on a new element' do
    @line_object.xyzzy.what.should == "item_0"
  end

  it 'should be able to instantiate as an already-added line object' do
    @line_object_added.class.should == OLE_QAF::Line_Object
    @line_object_added.new_line?.should be_false
    @line_object_added.fake_element.class.should == OLE_QAF::Data_Element
    @line_object_added.foo.class.should == OLE_QAF::Web_Element
    @line_object_added.bar.class.should == OLE_QAF::Web_Element
  end
  
  it 'should replace LINENUM in an identifier string with 1' do
    @line_object_added.foo.what.should == "item_1"
  end

  it 'should replace LINEID in an identifier string with 0' do
    @line_object_added.bar.what.should == "item_0"
  end

end