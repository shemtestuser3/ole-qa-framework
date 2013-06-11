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

describe 'The Bib Editor' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @browser = @ole.browser
    @bib_editor = OLE_QAF::OLELS::Bib_Editor.new(@browser, @ole.ls_url)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @bib_editor.class.should == OLE_QAF::OLELS::Bib_Editor
  end

  it 'should be a subclass of OLELS editor' do
    @bib_editor.class.superclass.should == OLE_QAF::OLELS::Editor
  end

  it 'should have a data line counter' do
    @bib_editor.data_line_counter.should == 1
  end

  it 'should have a control line counter' do
    @bib_editor.control_line_counter.should == 1
  end

  it 'should have bib editor elements' do
    @bib_editor.save_message.class.should == OLE_QAF::Data_Element
    @bib_editor.delete_bib_button.class.should == OLE_QAF::Web_Element
    @bib_editor.holdings_link_array.class.should == OLE_QAF::Web_Element_Array
    @bib_editor.item_link_array.class.should == OLE_QAF::Web_Element_Array
    @bib_editor.add_instance_button.class.should == OLE_QAF::Web_Element
    @bib_editor.delete_instance_array.class.should == OLE_QAF::Web_Element_Array
    @bib_editor.add_item_array.class.should == OLE_QAF::Web_Element_Array
    @bib_editor.delete_item_array.class.should == OLE_QAF::Web_Element_Array
  end

  it 'should open the Bib Editor via URL' do
    @bib_editor.open
    @bib_editor.title.verify_text("Bibliographic Editor - MARC Format").should be_true
  end

  it 'should enter a value for the leader field' do
    @bib_editor.leader_line.value_field.type("HelloWorld")
    @bib_editor.leader_line.value_field.value.should == "HelloWorld"
  end

  it 'should enter a control tag value' do
    @bib_editor.control_line_1.tag_field.type("008")
    @bib_editor.control_line_1.tag_field.value.should == "008"
  end

  it 'should enter a control field value' do
    @bib_editor.control_line_1.value_field.type("HelloWorld")
    @bib_editor.control_line_1.value_field.value.should == "HelloWorld"
  end

  it 'should enter a data tag value' do
    @bib_editor.data_line_1.tag_field.type('245')
    @bib_editor.data_line_1.tag_field.value.should == "245"
  end

  it 'should enter data indicator field values' do
    @bib_editor.data_line_1.indicator_1_field.type('1')
    @bib_editor.data_line_1.indicator_2_field.type('0')
    @bib_editor.data_line_1.indicator_1_field.value.should == "1"
    @bib_editor.data_line_1.indicator_2_field.value.should == "0"
  end

  it 'should enter a data field value' do
    @bib_editor.data_line_1.value_field.type('|aHello World')
    @bib_editor.data_line_1.value_field.value.should == "|aHello World"
  end

  it 'should add a control line' do
    @bib_editor.add_control_line
    @bib_editor.control_line_2.class.should == OLE_QAF::OLELS::Bib_Editor_Line
  end

  it 'should increment the control line counter when a control line is added' do
    @bib_editor.control_line_counter.should == 2
  end

  it 'should remove a control line' do
    @bib_editor.control_line_2.tag_field.type('008')
    @bib_editor.control_line_2.value_field.type('HelloKitty')
    @bib_editor.delete_control_line(1)
    @bib_editor.control_line_2.class.should == NilClass
    @bib_editor.control_line_1.class.should == OLE_QAF::OLELS::Bib_Editor_Line
  end

  it 'should decrement the control line counter when a control line is removed' do
    @bib_editor.control_line_counter.should == 1
  end

  it 'should add a data line' do
    @bib_editor.add_data_line
    @bib_editor.data_line_2.class.should == OLE_QAF::OLELS::Bib_Editor_Line
  end

  it 'should increment the data line counter when a data line is added' do
    @bib_editor.data_line_counter.should == 2
  end

  it 'should remove a data line' do
    @bib_editor.data_line_2.tag_field.type('245')
    @bib_editor.data_line_2.value_field.type('|aA Testing Title')
    @bib_editor.delete_data_line(1)
    @bib_editor.data_line_2.class.should == NilClass
    @bib_editor.data_line_1.class.should == OLE_QAF::OLELS::Bib_Editor_Line
  end

  it 'should decrement the data line counter when a data line is removed' do
    @bib_editor.data_line_counter.should == 1
  end

  it 'should save the record' do
    @bib_editor.save
  end

end