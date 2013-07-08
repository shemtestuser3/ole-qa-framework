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
  # The OLE Library System Main Menu Page
  class Main_Menu < OLE_QA::Framework::Page
    # Set page URL to OLE Library System URL
    def initialize(ole_session)
      url = ole_session.ls_url
      super(ole_session, url)
    end

    def set_elements
      super
      element(:loan_link)                 {b.link(:text => "Loan")}
      element(:return_link)               {b.link(:text => "Return")}
      element(:editor_link)               {b.link(:text => "Editor")}
    end
  end
end