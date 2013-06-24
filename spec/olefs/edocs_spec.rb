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


describe 'An OLEFS E-Document' do

  before :all do
    @ole = OLE_QA::Framework.new
    @edoc = OLE_QA::OLEFS::E_Doc.new(@ole,@ole.base_url)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @edoc.class.should == OLE_QA::OLEFS::E_Doc
  end

  it 'should be a page' do
    @edoc.class.superclass.should == OLE_QA::Page
  end

  it 'should have E-document elements' do
    elements = @edoc.methods
    # General Info
    elements.include?(:title).should be_true
    # Header Area
    elements.include?(:document_id).should be_true
    elements.include?(:document_status).should be_true
    elements.include?(:document_type_id).should be_true
    elements.include?(:document_type_status).should be_true
    elements.include?(:document_create_date).should be_true
    # Document Overview
    elements.include?(:document_overview_tab_toggle).should be_true
    elements.include?(:description_field).should be_true
    elements.include?(:explanation_field).should be_true
    # Global Input Buttons
    elements.include?(:approve_button).should be_true
    elements.include?(:save_button).should be_true
    elements.include?(:submit_button).should be_true
    elements.include?(:calculate_button).should be_true
    elements.include?(:close_button).should be_true
    elements.include?(:cancel_button).should be_true
    elements.include?(:copy_button).should be_true
    # Confirmation Screen Buttons
    elements.include?(:close_yes_button).should be_true
    elements.include?(:close_no_button).should be_true
    elements.include?(:cancel_yes_button).should be_true
    elements.include?(:cancel_no_button).should be_true
    # Messages
    elements.include?(:save_message).should be_true
    elements.include?(:submit_message).should be_true
    elements.include?(:error_message).should be_true
    elements.include?(:generic_message).should be_true
    # Multiple Error Message Components     Watir::HTMLElementCollection
    elements.include?(:errors_in_tab).should be_true
    elements.include?(:get_error_array).should be_true
  end
end