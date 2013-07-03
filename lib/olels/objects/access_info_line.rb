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
  # An Access Information Line on the OLE Library System Instance Record Editor
  class Access_Info_Line < OLE_QA::Framework::OLELS::Line_Object
    # Set screen elements for access info line.
    def set_elements
      element(:access_info_field)                     {b.text_field(:id => "OleAccessInformationField_line#{@line_id}_control")}
      element(:add_button)                            {b.button(:id => "oleAccessInformation_addTagButton_line#{@line_id}")}
      element(:remove_button)                         {b.button(:id => "oleAccessInformation_removeTagButton_line#{@line_id}")}
    end
  end
end