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
    @ole = OLE_QA::Framework.new

    class TestObject
      include OLE_QA::Helpers
      def initialize(ole_session)
        make_accessor(:foo)
        @foo = "foo"
        make_reader(:plugh)
        @plugh = "plugh"
        make_writer(:xyzzy)
        @xyzzy = ""
      end
      def give_xyzzy
        @xyzzy
      end
    end

    @test_object = TestObject.new(@ole)
  end

  it 'should do create an accessor attribute' do
    @test_object.foo.should == "foo"
    @test_object.foo = "foo bar baz"
    @test_object.foo.should == "foo bar baz"
  end

  it 'should create a reader attribute' do
    @test_object.plugh.should == "plugh"
  end

  it 'should create a writer attribute' do
    @test_object.xyzzy = "xyzzy"
    @test_object.give_xyzzy.should == "xyzzy"
  end
end