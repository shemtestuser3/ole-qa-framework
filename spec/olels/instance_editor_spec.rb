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

describe 'An OLELS Instance Editor page' do

  before :all do
    @ole = OLE_QA::Framework::Session.new
    @browser = @ole.browser
    @instance_editor = OLE_QA::Framework::OLELS::Instance_Editor.new(@ole)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @instance_editor.class.should == OLE_QA::Framework::OLELS::Instance_Editor
    @instance_editor.class.superclass.should == OLE_QA::Framework::OLELS::Editor
  end

  it 'should have instance editor elements' do
    elements = @instance_editor.methods
    elements.include?(:location_toggle).should be_true
    elements.include?(:location_field).should be_true
    elements.include?(:call_number_toggle).should be_true
    elements.include?(:prefix_field).should be_true
    elements.include?(:shelving_order_field).should be_true
    elements.include?(:call_number_type_selector).should be_true
    elements.include?(:call_number_browse_button).should be_true
    elements.include?(:ownership_extent_toggle).should be_true
    elements.include?(:extended_information_toggle).should be_true
    elements.include?(:receipt_status_selector).should be_true
    elements.include?(:holding_notes_toggle).should be_true
    elements.include?(:holdings_notes_toggle).should be_true
  end

  it 'should start with line objects' do
    @instance_editor.methods.include?(:ownership_extent_line_1).should be_true
    @instance_editor.methods.include?(:access_info_line_1).should be_true
    @instance_editor.methods.include?(:holdings_note_1).should be_true
    @instance_editor.ownership_extent_line_1.class.should == OLE_QA::Framework::OLELS::Ownership_Extent_Line
    @instance_editor.access_info_line_1.class.should == OLE_QA::Framework::OLELS::Access_Info_Line
    @instance_editor.holdings_note_1.class.should == OLE_QA::Framework::OLELS::Holdings_Note
  end

  it 'should add line objects' do
    @instance_editor.add_ownership_extent_line(2)
    @instance_editor.methods.include?(:ownership_extent_line_2).should be_true
    @instance_editor.ownership_extent_line_2.class.should == OLE_QA::Framework::OLELS::Ownership_Extent_Line
    @instance_editor.add_access_info_line(2)
    @instance_editor.methods.include?(:access_info_line_2).should be_true
    @instance_editor.access_info_line_2.class.should == OLE_QA::Framework::OLELS::Access_Info_Line
    @instance_editor.add_holdings_note(2)
    @instance_editor.methods.include?(:holdings_note_2).should be_true
    @instance_editor.holdings_note_2.class.should == OLE_QA::Framework::OLELS::Holdings_Note
  end

  it 'should remove line objects' do
    @instance_editor.remove_ownership_extent_line(2)
    @instance_editor.methods.include?(:ownership_extent_line_2).should be_false
    @instance_editor.remove_access_info_line(2)
    @instance_editor.methods.include?(:access_info_line_2).should be_false
    @instance_editor.remove_holdings_note(2)
    @instance_editor.methods.include?(:holdings_note_2).should be_false
  end
end