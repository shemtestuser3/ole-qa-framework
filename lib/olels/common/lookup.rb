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

module OLE_QA::Framework::OLELS
  # A lookup screen in the OLE Library System
  class Lookup < OLE_QA::Framework::Page
    # Set elements common to all OLELS lookup screens.
    def set_elements
      super
      element(:title)                           {b.h1.span(:class => "uif-headerText-span")}
    end

    # Set elements to be loaded before the page is considered complete.
    def wait_for_elements
      super
      @wait_on << :title
    end
  end
end