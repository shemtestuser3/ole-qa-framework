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
    @ole = OLE_QAF::Framework.new
    @browser = @ole.browser
    @invoice_notes = OLE_QAF::OLEFS::Invoice_Notes_Line.new(@browser, 1, 1)
    @invoice_notes_added = OLE_QAF::OLEFS::Invoice_Notes_Line.new(@browser, 1, 1, false)
  end

  it 'should create a new instance' do
    @invoice_notes.class.should == OLE_QAF::OLEFS::Invoice_Notes_Line
    @invoice_notes.class.superclass.should == OLE_QAF::Subline_Object
  end

  it 'should have invoice notes line elements' do
    @invoice_notes.note_field.class.should == OLE_QAF::Input_Element
    @invoice_notes.add_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have invoice notes line elements' do
    @invoice_notes_added.note_field.class.should == OLE_QAF::Input_Element
    @invoice_notes_added.delete_button.class.should == OLE_QAF::Web_Element
  end
end