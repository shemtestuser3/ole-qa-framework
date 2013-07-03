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
    @ole = OLE_QA::Framework::Session.new
    @editor = OLE_QA::Framework::OLELS::Editor.new(@ole)
  end

  after :all do
    @ole.quit
  end

  it 'should create a new instance of the Editor base class' do
    @editor.class.should == OLE_QA::Framework::OLELS::Editor
  end

  it 'should should be a page' do
    @editor.class.superclass.should == OLE_QA::Framework::Page
  end

  it 'should open the Marc Editor via URL' do
    @editor.open
    @editor.title.text.should == "Bibliographic Editor - MARC Format"
  end

  it 'should have editor elements' do
    elements = @editor.methods
    elements.include?(:title).should be_true
    elements.include?(:submit_button).should be_true
    elements.include?(:cancel_button).should be_true
    elements.include?(:close_button).should be_true
    elements.include?(:return_to_search_button).should be_true
    elements.include?(:message).should be_true
  end

  it 'should wait for a title to be present' do
    @editor.wait_for_page_to_load.should == [:title]
  end
end