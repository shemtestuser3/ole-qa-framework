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

describe 'A Bib Editor Line' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @browser = @ole.browser
    @leader_line = OLE_QAF::OLELS::Bib_Editor_Line.new(@browser, 1, 'leader')
    @control_line_1 = OLE_QAF::OLELS::Bib_Editor_Line.new(@browser, 1, 'control')
    @data_line = OLE_QAF::OLELS::Bib_Editor_Line.new(@browser, 1, 'data')
  end

  after :all do
    @ole.quit
  end

  it 'should create new instances' do
    @leader_line.class.should == OLE_QAF::OLELS::Bib_Editor_Line
    @control_line_1.class.should == OLE_QAF::OLELS::Bib_Editor_Line
    @data_line.class.should == OLE_QAF::OLELS::Bib_Editor_Line
  end

  it 'should create a value field for a leader line' do
    @leader_line.value_field.class.should == OLE_QAF::Input_Element
  end

  it 'should create a tag field for a control line' do
    @control_line_1.tag_field.class.should == OLE_QAF::Input_Element
  end

  it 'should set the line identifier to 0 in the control line tag field' do
    /0/.match(@control_line_1.tag_field.what).nil?.should be_false
  end

  it 'should create a value field for a control line' do
    @control_line_1.value_field.class.should == OLE_QAF::Input_Element
  end

  it 'should set the line identifier to 0 in the control line value field' do
    /0/.match(@control_line_1.value_field.what).nil?.should be_false
  end

  it 'should create an add button for a control line' do
    @control_line_1.add_button.class.should == OLE_QAF::Web_Element
  end

  it 'should create a remove button for a control line' do
    @control_line_1.remove_button.class.should == OLE_QAF::Web_Element
  end

  it 'should create a tag field for a data line' do
    @data_line.tag_field.class.should == OLE_QAF::Input_Element
  end

  it 'should set the line identifier to 0 in the data line tag field' do
    /0/.match(@data_line.tag_field.what).nil?.should be_false
  end

  it 'should create an indicator 1 field for a data line' do
    @data_line.indicator_1_field.class.should == OLE_QAF::Input_Element
  end

  it 'should set the line identifier to 0 in the data line indicator 1 field' do
    /0/.match(@data_line.indicator_1_field.what).nil?.should be_false
  end

  it 'should create an indicator 1 field for a data line' do
    @data_line.indicator_2_field.class.should == OLE_QAF::Input_Element
  end

  it 'should set the line identifier to 0 in the data line indicator 2 field' do
    /0/.match(@data_line.indicator_2_field.what).nil?.should be_false
  end

  it 'should create a value field for a data line' do
    @data_line.value_field.class.should == OLE_QAF::Input_Element
  end

  it 'should set the line identifier to 0 in the data line value field' do
    /0/.match(@data_line.value_field.what).nil?.should be_false
  end

  it 'should create an add button for a data line' do
    @data_line.add_button.class.should == OLE_QAF::Web_Element
  end

  it 'should create a remove button for a data line' do
    @data_line.remove_button.class.should == OLE_QAF::Web_Element
  end
end