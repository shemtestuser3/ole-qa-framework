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

describe 'The Editor base class' do

  before :all do
    @ole = OLE_QAF::Framework.new
    @editor = OLE_QAF::OLELS::Editor.new(@ole.browser, @ole.ls_url)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance of the Editor base class' do
    @editor.class.should == OLE_QAF::OLELS::Editor
  end

  it 'should should be a page' do
    @editor.class.superclass.should == OLE_QAF::Page
  end

  it 'should have a title element' do
    @editor.title.class.should == OLE_QAF::Data_Element
  end

  it 'should have a submit button' do
    @editor.submit_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have a cancel button' do
    @editor.cancel_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have a close button' do
    @editor.close_button.class.should == OLE_QAF::Web_Element
  end

  it 'should have a return to search button' do
    @editor.return_to_search_button.class.should == OLE_QAF::Web_Element
  end

  it 'should open the Marc Editor' do
    @editor.open
    @ole.browser.current_url.should == @editor.url
  end

end