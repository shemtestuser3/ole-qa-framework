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

describe 'An OLELS Editor Note object' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @browser = @ole.browser
    @editor_note_access = OLE_QAF::OLELS::Editor_Note.new(@browser, 'access info',1)
    @editor_note_holdings = OLE_QAF::OLELS::Editor_Note.new(@browser, 'holdings note',1)
    @editor_note_ownership = OLE_QAF::OLELS::Editor_Note.new(@browser, 'ownership note', 1, 1)
    @editor_note_item = OLE_QAF::OLELS::Editor_Note.new(@browser, 'item note', 1)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @editor_note_access.class.should == OLE_QAF::OLELS::Editor_Note
    @editor_note_access.class.superclass.should == OLE_QAF::Data_Object
    @editor_note_holdings.class.should == OLE_QAF::OLELS::Editor_Note
    @editor_note_holdings.class.superclass.should == OLE_QAF::Data_Object
    @editor_note_ownership.class.should == OLE_QAF::OLELS::Editor_Note
    @editor_note_ownership.class.superclass.should == OLE_QAF::Data_Object
  end

  it 'should have access info elements' do
    @editor_note_access.access_info_field.class.should == OLE_QAF::Input_Element
    @editor_note_access.add_button.class.should == OLE_QAF::Web_Element
    @editor_note_access.remove_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have holdings note elements' do
    @editor_note_holdings.note_type_selector.class.should == OLE_QAF::Selector_Element
    @editor_note_holdings.note_field.class.should == OLE_QAF::Input_Element
    @editor_note_holdings.add_button.class.should == OLE_QAF::Web_Element
    @editor_note_holdings.add_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have ownership note elements' do
    @editor_note_ownership.note_type_selector.class.should == OLE_QAF::Selector_Element
    @editor_note_ownership.note_field.class.should == OLE_QAF::Input_Element
    @editor_note_ownership.add_button.class.should == OLE_QAF::Web_Element
    @editor_note_ownership.remove_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have item note elements' do
    @editor_note_item.note_type_selector.class.should == OLE_QAF::Selector_Element
    @editor_note_item.note_field.class.should == OLE_QAF::Input_Element
    @editor_note_item.add_button.class.should == OLE_QAF::Web_Element
    @editor_note_item.remove_button.class.should == OLE_QAF::Web_Element
  end

  it 'should replace line & subline numbers in element identifiers' do
    @editor_note_access.access_info_field.what.should  == 'OleAccessInformationField_line0_control'
    @editor_note_holdings.note_field.what.should == 'OleHoldingNoteDescField_line0_control'
    @editor_note_ownership.note_field.what.should == 'extentSubHoldingNoteDescField_line0_line0_control'
  end
end