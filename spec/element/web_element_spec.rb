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


describe "A Web Element" do

  before :all do
    @ole = OLE_QAF::Framework.new
    @ole.browser.get("http://www.google.com")
  end

  after :all do
    @ole.quit
  end

  it "should define a screen element" do
    element = OLE_QAF::Web_Element.new(@ole.browser, :name, "q")
  end

  it "should define an input element" do
    input = OLE_QAF::Input_Element.new(@ole.browser, :name, "q")
    input.type("Hello, World")
    input.value.should == "Hello, World"
  end

  it "should define a data element" do
    data_element = OLE_QAF::Data_Element.new(@ole.browser, :name, "q")
    data_element.value.should == "Hello, World"
    data_element.verify_value("Hello, World").should be_true
    other_element = OLE_QAF::Data_Element.new(@ole.browser, :id, 'msg_box_rendered')
    other_element.verify_text("hello world").should be_true
  end

  it "should determine whether an element is present" do
    element = OLE_QAF::Web_Element.new(@ole.browser, :name, "q")
    element.present?.should be_true
  end

  it "should wait for an element to be present" do
    element = OLE_QAF::Web_Element.new(@ole.browser, :name, "q")
    element.wait_til_present(@ole.explicit_wait)
  end

end