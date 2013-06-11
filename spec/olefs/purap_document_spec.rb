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
    @ole = OLE_QAF::Framework.new
    @purap_document = OLE_QAF::OLEFS::PURAP_Document.new(@ole.browser, @ole.base_url)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance' do
    @purap_document.class.should == OLE_QAF::OLEFS::PURAP_Document
    @purap_document.class.superclass.should == OLE_QAF::OLEFS::E_Doc
  end

  it 'should have route log elements' do
    @purap_document.route_log_tab_toggle.class.should == OLE_QAF::Web_Element
    @purap_document.actions_taken_array.class.should == OLE_QAF::Web_Element_Array
    @purap_document.actions_taken_by_array.class.should == OLE_QAF::Web_Element_Array
  end
end