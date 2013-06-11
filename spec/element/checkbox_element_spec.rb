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


describe 'A Checkbox Element' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @browser = @ole.browser
    @browser.get('http://sislands.com/coin70/week4/chkBoxTest.htm')
    how = :css
    what = 'form[name=testform] > input[name=check1]'
    @checkbox = OLE_QAF::Checkbox_Element.new(@browser, how, what)
  end

  after :all do
    @ole.quit
  end

  it 'should should create a new instance' do
    @checkbox.class.should == OLE_QAF::Checkbox_Element
  end

  it 'should be a subclass of Data Element' do
    @checkbox.class.superclass.should == OLE_QAF::Data_Element
  end

  it 'should click a checkbox' do
    @checkbox.click
  end

  it 'should answer that a checkbox is checked' do
    @checkbox.checked?.should be_true
  end

  it 'should verify that a checkbox is checked' do
    @checkbox.verify_checked.should be_true
  end

  it 'should uncheck a checkbox' do
    @checkbox.uncheck.should be_true
  end

  it 'should answer that a checkbox is unchecked' do
    @checkbox.checked?.should be_false
  end

  it 'should verify that a checkbox is unchecked' do
    @checkbox.verify_checked.should be_false
  end

  it 'should check a checkbox' do
    @checkbox.check.should be_true
    @checkbox.checked?.should be_true
  end

end