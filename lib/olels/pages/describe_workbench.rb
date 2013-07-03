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
  # The OLE Library System Describe Workbench Screen
  class Describe_Workbench < Lookup
    # Set URL
    def initialize(ole_session)
      url = ole_session.ls_url + 'portal.do?channelTitle=Describe Workbench&channelUrl='
      url += ole_session.ls_url + 'ole-kr-krad/describeworkbenchcontroller?viewId=DescribeWorkBenchView&methodToCall=start'
      super(ole_session, url)
    end

    # Set OLELS Describe Workbench page elements.
    def set_elements
      super
      # Buttons
      element(:search_button)                   {b.button(:id => "search_button")}
      element(:clear_button)                    {b.button(:id => "clear_button")}
      # Search Fields
      element(:search_field_1)                  {b.text_area(:id => "searchText_id_line0_control")}
      element(:search_which_selector_1)         {b.select_list(:id => "operator_id_line0_control")}
      element(:search_field_selector_1)         {b.select_list(:id => "docField_id_line0_control")}
    end

    def wait_for_elements
      super
      @wait_on << :search_button
    end
  end
end