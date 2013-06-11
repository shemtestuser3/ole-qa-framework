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
    @ole = OLE_QAF::Framework.new
    @edoc = OLE_QAF::OLEFS::E_Doc.new(@ole.browser, @ole.base_url)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @edoc.class.should == OLE_QAF::OLEFS::E_Doc
  end

  it 'should be a page' do
    @edoc.class.superclass.should == OLE_QAF::Page
  end

  it 'should have a title element' do
    @edoc.title.class.name.should == "OLE_QAF::Data_Element"
  end

  it 'should have document number elements' do
    @edoc.document_id.class.name.should == "OLE_QAF::Data_Element"
    @edoc.document_type_id.class.name.should == "OLE_QAF::Data_Element"
  end

  it 'should have document status elements' do
    @edoc.document_status.class.name.should == "OLE_QAF::Data_Element"
    @edoc.document_type_status.class.name.should == "OLE_QAF::Data_Element"
  end

  it 'should have a creation date element' do
    @edoc.document_create_date.class.name.should == "OLE_QAF::Data_Element"
  end

  it 'should have global input buttons' do
    web_element_class = "OLE_QAF::Web_Element"
    @edoc.approve_button.class.name.should == web_element_class
    @edoc.save_button.class.name.should == web_element_class
    @edoc.submit_button.class.name.should == web_element_class
    @edoc.reload_button.class.name.should == web_element_class
    @edoc.calculate_button.class.name.should == web_element_class
    @edoc.close_button.class.name.should == web_element_class
    @edoc.close_yes_button.class.name.should == web_element_class
    @edoc.close_no_button.class.name.should == web_element_class
    @edoc.cancel_button.class.name.should == web_element_class
    @edoc.copy_button.class.name.should == web_element_class
  end

  it 'should have message elements' do
    data_element_class = "OLE_QAF::Data_Element"
    web_array_class = "OLE_QAF::Web_Element_Array"
    @edoc.submit_message.class.name.should == data_element_class
    @edoc.error_message.class.name.should == data_element_class
    @edoc.generic_message.class.name.should == data_element_class
    @edoc.errors_in_section.class.name.should == web_array_class
  end
end