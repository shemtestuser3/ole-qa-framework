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

module OLE_QAF
  # The OLE Library System Main Menu Page
  class OLELS_Main_Menu < Page

    def initialize(ole_framework)
      browser = ole_framework.browser
      url = ole_framework.ls_url
      super(browser, url)
    end

    def open
      super
      login_button = Input_Element.new(@browser, :id, "log")
      if login_button.present? then
        login_button.click
      end
    end

  end
end