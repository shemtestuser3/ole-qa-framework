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

describe 'The Helpers module' do

  before :all do
    @ole = OLE_QA::Framework::Session.new
    @fs_page = OLE_QA::Framework::Page.new(@ole, @ole.fs_url)
    @ls_page = OLE_QA::Framework::Page.new(@ole, @ole.ls_url)
  end

  it 'should be able to login to OLEFS' do
    @fs_page.open
    @fs_page.login("ole-abeal").should be_true
  end

  it 'should be able to logout from OLEFS' do
    @fs_page.logout.should be_true
  end

  it 'should be able to login to OLELS' do
    @ls_page.open
    @ls_page.login("dev2").should be_true
  end

  it 'should be able to logout from OLELS' do
    @ls_page.logout.should be_true
  end
end