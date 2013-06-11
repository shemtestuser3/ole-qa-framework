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


describe 'An OLELS E-Document' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @edoc = OLE_QAF::OLELS::E_Doc.new(@ole.browser, @ole.ls_url)
  end

  after :all do
    @ole.quit
  end

  it 'should should create a new instance' do
    @edoc.class.should == OLE_QAF::OLELS::E_Doc
  end

  it 'should be a page' do
    @edoc.class.superclass.should == OLE_QAF::Page
  end

  it 'should have document header elements' do

  end

  it 'should have document overview elements' do
    @edoc.description.class.should == OLE_QAF::Input_Element
  end

end