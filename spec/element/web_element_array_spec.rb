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


describe 'An array of web elements' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @ole.browser.get("http://www.kuali.org/ole")
    @element = OLE_QAF::Web_Element_Array.new(@ole.browser, :xpath, '//a')
  end

  after :all do
    @ole.quit
  end

  it 'should be an array' do
    @element.array.class.should == Array
  end

  it 'should contain Selenium WebDriver elements' do
    @element.array[0].class.should == Selenium::WebDriver::Element
  end

  it 'should have text values for elements' do
    @element.array[1].text.class.should == String
  end

  it 'should return an array of elements with matching text values' do
    match_ary = @element.match_text(/Kuali/)
    match_ary.class.should == Array
    match_ary.count.should >= 1
  end

  it 'should return an array of elements with matching value attributes' do
    match_ary = @element.match_text(/Kuali/)
    match_ary.class.should == Array
    match_ary.count.should >= 1
  end

end