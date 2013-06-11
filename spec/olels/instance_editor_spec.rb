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
    @ole = OLE_QAF::Framework.new
    @browser = @ole.browser
    @instance_editor = OLE_QAF::OLELS::Instance_Editor.new(@browser, @ole.ls_url)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @instance_editor.class.should == OLE_QAF::OLELS::Instance_Editor
    @instance_editor.class.superclass.should == OLE_QAF::OLELS::Editor
  end

  it 'should have instance editor elements' do
    @instance_editor.location_toggle.class.should == OLE_QAF::Web_Element
    @instance_editor.location_field.class.should == OLE_QAF::Input_Element
    @instance_editor.call_number_toggle.class.should == OLE_QAF::Web_Element
    @instance_editor.prefix_field.class.should == OLE_QAF::Input_Element
    @instance_editor.call_number_field.class.should == OLE_QAF::Input_Element
    @instance_editor.shelving_order_field.class.should == OLE_QAF::Input_Element
    @instance_editor.call_number_type_selector.class.should == OLE_QAF::Selector_Element
    @instance_editor.call_number_browse_button.class.should == OLE_QAF::Web_Element
    @instance_editor.ownership_extent_toggle.class.should == OLE_QAF::Web_Element
    @instance_editor.extended_information_toggle.class.should == OLE_QAF::Web_Element
    @instance_editor.receipt_status_selector.class.should == OLE_QAF::Selector_Element
    @instance_editor.holding_notes_toggle.class.should == OLE_QAF::Web_Element
  end

  it 'should have an ownership extent line' do
    @instance_editor.ownership_extent_line_1.class.should == OLE_QAF::OLELS::Ownership_Extent_Line
    @instance_editor.ownership_extent_line_counter.should == 1
  end

  it 'should have an access info line' do
    @instance_editor.access_info_line_1.class.should == OLE_QAF::OLELS::Editor_Note
    @instance_editor.access_info_line_counter.should == 1
  end

  it 'should have a holdings note line' do
    @instance_editor.holdings_note_1.class.should == OLE_QAF::OLELS::Editor_Note
    @instance_editor.holdings_note_counter.should == 1
  end

  it 'should add an ownership extent line' do
    @instance_editor.add_ownership_extent_line(do_click = false)
    @instance_editor.ownership_extent_line_2.class.should == OLE_QAF::OLELS::Ownership_Extent_Line
    @instance_editor.ownership_extent_line_counter.should == 2
  end

  it 'should add an access info line' do
    @instance_editor.add_access_info_line(do_click = false)
    @instance_editor.access_info_line_2.class.should == OLE_QAF::OLELS::Editor_Note
    @instance_editor.access_info_line_counter.should == 2
  end

  it 'should add a holdings note line' do
    @instance_editor.add_holdings_note(do_click = false)
    @instance_editor.holdings_note_2.class.should == OLE_QAF::OLELS::Editor_Note
    @instance_editor.holdings_note_counter.should == 2
  end

  it 'should delete an ownership extent line' do
    @instance_editor.delete_ownership_extent_line(2, false)
    @instance_editor.ownership_extent_line_2.class.should == NilClass
    @instance_editor.ownership_extent_line_counter.should == 1
  end

  it 'should delete an access info line' do
    @instance_editor.delete_access_info_line(2, false)
    @instance_editor.access_info_line_2.class.should == NilClass
    @instance_editor.access_info_line_counter.should == 1
  end

  it 'should delete a holdings note line' do
    @instance_editor.delete_holdings_note(2, false)
    @instance_editor.holdings_note_2.class.should == NilClass
    @instance_editor.holdings_note_counter.should == 1
  end
end