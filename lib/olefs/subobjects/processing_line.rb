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

module OLE_QA::Framework::OLEFS
  # A Special Processing Instructions Line in an OLE Financial System Receiving Document.
  class Processing_Line < OLE_QA::Framework::Subline_Object
    def set_elements
      super
      element(:note_field)                {b.td(:xpath => "//table[@summary='Items Section']/tbody/tr[td[1]/b[contains(text(),'#{@line_number}')]]/following-sibling::tr[4]/td[1]/table/tbody/tr[2]/td[1]/table/tbody/tr[td[contains(text(),'Note #{@subline_number}')]]/following-sibling::tr[1]/td[1]")}
      element(:acknowledge_checkbox)      {b.checkbox(:xpath => "//table[@summary='Items Section']/tbody/tr[td[1]/b[contains(text(),'#{@line_number}')]]/following-sibling::tr[4]/td[1]/table/tbody/tr[2]/td[1]/table/tbody/tr[td[contains(text(),'Note #{@subline_number}')]]/following-sibling::tr[1]/td[2]")}
    end
  end
end