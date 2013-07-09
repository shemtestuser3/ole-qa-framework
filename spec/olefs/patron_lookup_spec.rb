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

describe 'A Patron Lookup page' do

  before :all do
    @ole = OLE_QA::Framework::Session.new
    @patron_lookup = OLE_QA::Framework::OLELS::Patron_Lookup.new(@ole)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @patron_lookup.class.should == OLE_QA::Framework::OLELS::Patron_Lookup
    @patron_lookup.class.superclass.should == OLE_QA::Framework::OLELS::Lookup
  end

  it 'should open the Patron Lookup screen via URL' do
    @patron_lookup.open
    @patron_lookup.title.text.should == "Patron"
  end

  it 'should have patron lookup elements' do
    elements = @patron_lookup.elements
    elements.include?(:patron_id_field).should be_true
    elements.include?(:barcode_field).should be_true
    elements.include?(:first_name_field).should be_true
    elements.include?(:last_name_field).should be_true
    elements.include?(:borrower_type_selector).should be_true
    elements.include?(:email_address_field).should be_true
    elements.include?(:search_button).should be_true
    elements.include?(:clear_button).should be_true
    elements.include?(:cancel_button).should be_true
    elements.include?(:active_yes_button).should be_true
    elements.include?(:active_no_button).should be_true
    elements.include?(:active_both_button).should be_true
  end
end