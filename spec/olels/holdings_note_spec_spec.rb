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

describe 'An OLELS Holdings Note object' do

  before :all do
    @ole = OLE_QA::Framework.new
    @holdings_note = OLE_QA::OLELS::Holdings_Note.new(@ole,1)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @holdings_note.class.should == OLE_QA::OLELS::Holdings_Note
    @holdings_note.class.superclass.should == OLE_QA::OLELS::Line_Object
  end

  it 'should have holdings note elements' do
    elements = @holdings_note.methods
    elements.include?(:note_type_selector)
    elements.include?(:note_field)
    elements.include?(:add_button)
    elements.include?(:remove_button)
  end
end