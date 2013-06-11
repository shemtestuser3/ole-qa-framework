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

describe 'A Subline Object' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @yaml_path = "/common/subline_object/"
    @line_num = 2
    @subline_num = 1
    @subline = OLE_QAF::Subline_Object.new(@ole.browser, @yaml_path, @line_num, @subline_num)
    @subline_added = OLE_QAF::Subline_Object.new(@ole.browser, @yaml_path, @line_num, @subline_num, new_line = false)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @subline.class.should == OLE_QAF::Subline_Object
  end

  it 'should be a subclass of line object' do
    @subline.class.superclass.should == OLE_QAF::Line_Object
  end

  it 'should have a YAML file path' do
    @subline.yaml_path.should == @yaml_path
  end

  it 'should have a line number' do
    @subline.line_number.should == 2
  end

  it 'should have a line identifier' do
    @subline.line_identifier.should == 1
  end

  it 'should have a subline number' do
    @subline.subline_number.should == 1
  end

  it 'should have a subline identifier' do
    @subline.subline_identifier.should == 0
  end

  it 'should create a subline element' do
    @subline.fake_element.class.should == OLE_QAF::Web_Element
  end

  it 'should replace SUBLINENUM in an identifier string with a 1 on a new element' do
    @subline.plugh.what.should == "item_2_1"
  end

  it 'should replace SUBLINEID in an identifier string with a 0 on a new element' do
    @subline.xyzzy.what.should == "item_1_0"
  end

  it 'should be able to instantiate as an already-added subline object' do
    @subline_added.class.should == OLE_QAF::Subline_Object
    @subline_added.new_line?.should be_false
    @subline_added.fake_element.class.should == OLE_QAF::Data_Element
    @subline_added.foo.class.should == OLE_QAF::Web_Element
    @subline_added.bar.class.should == OLE_QAF::Web_Element
  end

  it 'should replace SUBLINENUM in an identifier string with 1 on an added subline' do
    @subline_added.foo.what.should == "item_2_1"
  end

  it 'should replace SUBELINEID in an identifier string with 0 on an added subline' do
    @subline_added.bar.what.should == "item_1_0"
  end

end