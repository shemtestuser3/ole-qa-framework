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

describe 'An OLEFS Lookup page' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @lookup = OLE_QAF::OLEFS::Lookup.new(@ole.browser, @ole.base_url)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @lookup.class.should == OLE_QAF::OLEFS::Lookup
    @lookup.class.superclass.should == OLE_QAF::Page
  end

  it 'should have lookup page screen elements' do
    @lookup.title.class.should == OLE_QAF::Data_Element
    @lookup.active_indicator_yes.class.should == OLE_QAF::Checkbox_Element
    @lookup.active_indicator_no.class.should == OLE_QAF::Checkbox_Element
    @lookup.active_indicator_both.class.should == OLE_QAF::Checkbox_Element
    @lookup.search_button.class.should == OLE_QAF::Web_Element
    @lookup.cancel_button.class.should == OLE_QAF::Web_Element
    @lookup.clear_button.class.should == OLE_QAF::Web_Element
  end

end