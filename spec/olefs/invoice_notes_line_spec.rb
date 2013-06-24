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

describe 'An OLEFS Invoice Notes Line object' do

  before :all do
    @ole = OLE_QA::Framework.new
    @browser = @ole.browser
    @invoice_notes = OLE_QA::OLEFS::Invoice_Notes_Line.new(@ole, 1, 1)
    @new_invoice_notes = OLE_QA::OLEFS::New_Invoice_Notes_Line.new(@ole, 1, 0)
  end

  it 'should create a new instance' do
    @invoice_notes.class.should == OLE_QA::OLEFS::Invoice_Notes_Line
    @invoice_notes.class.superclass.should == OLE_QA::Subline_Object
    @new_invoice_notes.class.should == OLE_QA::OLEFS::New_Invoice_Notes_Line
    @new_invoice_notes.class.superclass.should == OLE_QA::Subline_Object
  end

  it 'should have invoice notes line elements' do
    methods = @invoice_notes.methods
    methods.include?(:note_field).should be_true
    methods.include?(:delete_button).should be_true
  end

  it 'should have new invoice notes line elements' do
    methods = @new_invoice_notes.methods
    methods.include?(:note_field).should be_true
    methods.include?(:add_button).should be_true
  end
end