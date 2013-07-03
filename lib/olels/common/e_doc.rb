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
  # An OLE Libary System E-Document page.
  class E_Doc < OLE_QA::Framework::Page
    # Set elements common to all OLELS E-Document pages.
    def set_elements
      element(:description_field)                     {b.text_field(:xpath => "//tr/th[descendant::label[contains(text(),'Description:')]]/following-sibling::td[1]/descendant::input[1]")}
    end
  end
end