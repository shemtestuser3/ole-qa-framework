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


describe 'An OLE_QAF Selector Element' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @ole.browser.get("http://kis.kuali.org")
    @selector = OLE_QAF::Selector_Element.new(@ole.browser, :id, "ProjectQuickSelect")
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @selector.class.should == OLE_QAF::Selector_Element
  end

  # This particular select element navigates to a new page, resetting
  # the selector value to ''.  If it was selected correctly, Kuali KIS
  # should return the OLE project page.
  it 'should select an option by a given method and value' do
    @selector.select_option(:text, "OLE")
    @ole.browser.find_element(:xpath, "//h1[@class='title']").text.should == "Kuali OLE"
  end

end