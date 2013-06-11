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

describe 'An accounting line' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @accounting_line = OLE_QAF::OLEFS::Accounting_Line.new(@ole.browser, 1, 1)
    @accounting_line_added = OLE_QAF::OLEFS::Accounting_Line.new(@ole.browser, 1, 1, new_line = false)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @accounting_line.class.should == OLE_QAF::OLEFS::Accounting_Line
  end

  it 'should be a subclass of subline object' do
    @accounting_line.class.superclass.should == OLE_QAF::Subline_Object
  end

  it 'should have a path to the YAML files' do
    @accounting_line.yaml_path.should == '/olefs/objects/accounting_line/'
  end

  it 'should have a browser accessor' do
    @accounting_line.browser.class.should == Selenium::WebDriver::Driver
  end

  it 'should have accounting line fields' do
    @accounting_line.chart_selector.class.should == OLE_QAF::Selector_Element
    @accounting_line.account_number_field.class.should == OLE_QAF::Input_Element
    @accounting_line.sub_account_field.class.should == OLE_QAF::Input_Element
    @accounting_line.object_field.class.should == OLE_QAF::Input_Element
    @accounting_line.sub_object_field.class.should == OLE_QAF::Input_Element
    @accounting_line.project_field.class.should == OLE_QAF::Input_Element
    @accounting_line.org_ref_id_field.class.should == OLE_QAF::Input_Element
    @accounting_line.dollar_field.class.should == OLE_QAF::Input_Element
    @accounting_line.percent_field.class.should == OLE_QAF::Input_Element
  end

  it 'should have an add button' do
    @accounting_line.add_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have accounting line fields' do
    @accounting_line_added.chart_selector.class.should == OLE_QAF::Selector_Element
    @accounting_line_added.account_number_field.class.should == OLE_QAF::Input_Element
    @accounting_line_added.sub_account_field.class.should == OLE_QAF::Input_Element
    @accounting_line_added.object_field.class.should == OLE_QAF::Input_Element
    @accounting_line_added.sub_object_field.class.should == OLE_QAF::Input_Element
    @accounting_line_added.project_field.class.should == OLE_QAF::Input_Element
    @accounting_line_added.org_ref_id_field.class.should == OLE_QAF::Input_Element
    @accounting_line_added.dollar_field.class.should == OLE_QAF::Input_Element
    @accounting_line_added.percent_field.class.should == OLE_QAF::Input_Element
  end

  it 'should have a delete button' do
    @accounting_line_added.delete_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have a balance inquiry button' do
    @accounting_line_added.balance_inquiry_button.class.should == OLE_QAF::Web_Element
  end

end