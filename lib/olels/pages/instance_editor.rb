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
  # The OLE Library System MARC Instance Record Editor Screen
  class Instance_Editor < Editor
    # Set OLELS Instance Editor page elements.
    def set_elements
      element(:location_toggle)                       {b.a(:id => "OleLocationInformationSection_toggle")}
      element(:location_field)                        {b.text_field(:id => "OleHoldingLocation_control")}
      element(:call_number_toggle)                    {b.a(:id => "OleCallNumberInformation_toggle")}
      element(:prefix_field)                          {b.text_field(:id => "OleHoldingCallNumber_control")}
      element(:shelving_order_field)                  {b.text_field(:id => "OleHoldingShelvingOrder_control")}
      element(:call_number_type_selector)             {b.select_list(:id => "OleHoldingShelvingScheme_control")}
      element(:call_number_browse_button)             {b.button(:id => "callNumberHoldingsBrowseLink")}
      element(:ownership_extent_toggle)               {b.a(:id => "OleExtentOfOwnershipSection_toggle")}
      element(:extended_information_toggle)           {b.a(:id => "OleExtendedInformationSection_toggle")}
      element(:receipt_status_selector)               {b.select_list(:id => "OleReceiptStatusField_control")}
      element(:holding_notes_toggle)                  {b.a(:id => "OleHoldingNotes_toggle")}
      element(:holdings_notes_toggle)                 {b.a(:id => "OleHoldingNotes_toggle")}
    end

    # Wait for location field to appear when opening page.
    def wait_for_elements
      super
      @wait_on << :location_field
    end

    def set_lines
      create_ownership_extent_line(1)
      create_access_info_line(1)
      create_holdings_note(1)
    end

    def create_ownership_extent_line(which = 1)
      create_line("ownership_extent_line_#{which}","Ownership_Extent_Line",which)
    end
    alias_method(:add_ownership_extent_line,:create_ownership_extent_line)

    def create_access_info_line(which = 1)
      create_line("access_info_line_#{which}","Access_Info_Line",which)
    end
    alias_method(:add_access_info_line,:create_access_info_line)

    def create_holdings_note(which = 1)
      create_line("holdings_note_#{which}","Holdings_Note",which)
    end
    alias_method(:add_holdings_note,:create_holdings_note)

    def remove_ownership_extent_line(which = 1)
      remove_line("ownership_extent_line_#{which}")
    end
    alias_method(:delete_ownership_extent_line,:remove_ownership_extent_line)

    def remove_access_info_line(which = 1)
      remove_line("access_info_line_#{which}")
    end
    alias_method(:delete_access_info_line,:remove_access_info_line)

    def remove_holdings_note(which = 1)
      remove_line("holdings_note_#{which}")
    end
    alias_method(:delete_holdings_note,:remove_holdings_note)
  end
end