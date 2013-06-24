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

module OLE_QA::OLELS

  # Represents a Marc data line in the OLE Library System Bib Editor.
  #   e.g. '245','','','|aTitle of Work'
  class Data_Line < OLE_QA::OLELS::Line_Object

    # Set Marc data line elements.
    def set_elements
      element(:tag_field)               {b.text_field(:id => "dataField_tag_id_line#{@line_id}_control")}
      element(:ind1_field)              {b.text_field(:id => "dataField_ind1_id_line#{@line_id}_control")}
      element(:ind2_field)              {b.text_field(:id => "dataField_ind2_id_line#{@line_id}_control")}
      element(:data_field)              {b.text_field(:id => "dataField_value_id_line#{@line_id}_control")}
      element(:add_button)              {b.button(:id => "dataField_addTagButton_id_line#{@line_id}")}
      element(:remove_button)           {b.button(:id => "dataField_removeTagButton_id_line#{@line_id}")}
    end
  end
end