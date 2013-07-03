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

describe 'An OLEFS Purap Document page' do

  before :all do
    @ole = OLE_QA::Framework::Session.new
    @purap_document = OLE_QA::Framework::OLEFS::PURAP_Document.new(@ole, @ole.base_url)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @purap_document.class.should == OLE_QA::Framework::OLEFS::PURAP_Document
    @purap_document.class.superclass.should == OLE_QA::Framework::OLEFS::E_Doc
  end

  it 'should have PURAP document elements' do
    elements = @purap_document.methods
    elements.include?(:view_related_tab_toggle).should be_true
    elements.include?(:view_related_po_link).should be_true
    elements.include?(:view_related_requisition_link).should be_true
    elements.include?(:delivery_tab_toggle).should be_true
    elements.include?(:building_field).should be_true
    elements.include?(:campus_field).should be_true
    elements.include?(:closed_room_field).should be_true
    elements.include?(:closed_building_field).should be_true
    elements.include?(:closed_campus_field).should be_true
    elements.include?(:closed_address_1_field).should be_true
    elements.include?(:closed_address_2_field).should be_true
    elements.include?(:closed_city_field).should be_true
    elements.include?(:closed_state_field).should be_true
    elements.include?(:closed_postal_code_field).should be_true
    elements.include?(:closed_country_field).should be_true
    elements.include?(:closed_delivery_to_field).should be_true
    elements.include?(:closed_delivery_phone_number_field).should be_true
    elements.include?(:closed_email_field).should be_true
    elements.include?(:route_log_tab_toggle).should be_true
    elements.include?(:vendor_tab_toggle).should be_true
    elements.include?(:closed_vendor_name_field).should be_true
  end
end