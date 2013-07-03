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

require "rspec"
require "spec_helper"


describe "A Page" do

  before :all do
    @ole = OLE_QA::Framework::Session.new
    @page = OLE_QA::Framework::Page.new(@ole, @ole.base_url)
  end

  it "should open via url" do
    @page.open
    @ole.browser.title.should == "Kuali Portal Index"
  end

  it 'should have a browser accessor' do
    @page.browser.class.should == @ole.browser.class
  end

  it 'should have a URL attribute' do
    @page.url.should == @ole.base_url
  end

  it 'should set a frame element on the browser if one is present' do
    @page.browser.link(:text => "Requisition").click
    @page.browser.class.should == Watir::Frame
  end

end