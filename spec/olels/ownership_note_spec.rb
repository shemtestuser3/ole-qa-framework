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

describe 'An OLELS Ownership Note object' do

  before :all do
    @ole = OLE_QA::Framework.new
    @ownership_note = OLE_QA::OLELS::Ownership_Note.new(@ole)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @ownership_note.class.should == OLE_QA::OLELS::Ownership_Note
    @ownership_note.class.superclass.should == OLE_QA::Subline_Object
  end

  it 'should have ownership note elements' do
    elements = @ownership_note.methods
    elements.include?(:note_type_selector).should be_true
    elements.include?(:note_field).should be_true
    elements.include?(:add_button).should be_true
    elements.include?(:remove_button).should be_true
  end
end