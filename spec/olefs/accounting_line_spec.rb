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
    @ole = OLE_QA::Framework.new
    @accounting_line = OLE_QA::OLEFS::Accounting_Line.new(@ole, 1, 1)
    @new_accounting_line = OLE_QA::OLEFS::New_Accounting_Line.new(@ole, 1, 0)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @accounting_line.class.should == OLE_QA::OLEFS::Accounting_Line
    @new_accounting_line.class.should == OLE_QA::OLEFS::New_Accounting_Line
  end

  it 'should be a subclass of subline object' do
    @accounting_line.class.superclass.should == OLE_QA::Subline_Object
    @new_accounting_line.class.superclass.should == OLE_QA::Subline_Object
  end

  it 'should have a browser accessor' do
    @accounting_line.browser.class.should == @ole.browser.class
    @new_accounting_line.browser.class.should == @ole.browser.class
  end

  it 'should have line number attributes' do
    @accounting_line.line_number.should == 1
    @accounting_line.subline_number.should == 1
    @new_accounting_line.line_number.should == 1
    @new_accounting_line.subline_number.should == 0
  end

  it 'should have accounting line elements' do
    methods_array = @accounting_line.methods
    methods_array.include?(:account_number_field).should be_true
    methods_array.include?(:sub_account_number_field).should be_true
    methods_array.include?(:object_field).should be_true
    methods_array.include?(:sub_object_field).should be_true
    methods_array.include?(:project_field).should be_true
    methods_array.include?(:org_ref_id_field).should be_true
    methods_array.include?(:dollar_field).should be_true
    methods_array.include?(:percent_field).should be_true
    methods_array.include?(:chart_selector).should be_true
    methods_array.include?(:delete_button).should be_true
    methods_array.include?(:balance_inquiry_button).should be_true
    methods_array.include?(:closed_chart_field).should be_true
    methods_array.include?(:closed_account_number_field).should be_true
    methods_array.include?(:closed_object_field).should be_true
    methods_array.include?(:closed_dollar_field).should be_true
    methods_array.include?(:closed_percent_field).should be_true
  end

  it 'should have new accounting line elements' do
    methods = @new_accounting_line.methods
    methods.include?(:chart_selector).should be_true
    methods.include?(:account_number_field).should be_true
    methods.include?(:sub_account_number_field).should be_true
    methods.include?(:object_field).should be_true
    methods.include?(:sub_object_field).should be_true
    methods.include?(:project_field).should be_true
    methods.include?(:org_ref_id_field).should be_true
    methods.include?(:dollar_field).should be_true
    methods.include?(:percent_field).should be_true
    methods.include?(:add_button).should be_true
  end
end