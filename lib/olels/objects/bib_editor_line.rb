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

module OLE_QAF::OLELS

  # Represents a single line in the Bib Editor with multiple fields.
  # Use this as a base class to create a Leader Field Line, a Control
  # Field Line, and Marc Field Lines.
  #
  # Choose the appropriate field type as described in initialize.
  #
  class Bib_Editor_Line < OLE_QAF::Data_Object

    attr_accessor :yaml_file, :line_number, :line_identifier, :line_type

    # browser -> active Selenium WebDriver session
    #     e.g., Bib_Editor_Line.new( @ole.browser )
    #
    # line_number -> Human-readable line number, starting at 1.
    #     IDs are assumed to use line_identifier (line_number -1)
    #
    #
    # line_type -> type of Bib Editor line to create:
    #       'leader'       -- Marc Leader Field
    #       'control'      -- Marc Control Field
    #       'data'         -- Marc Data Field
    #                           (e.g., '245','0','','|aTitle')
    #       Defaults to 'data'
    #
    #
    # NB! This class assumes that the identifier strings (the last
    # value of the array in a given member of an element hash)
    # will contain the target text LINEID anywhere that the line
    # identifier value needs to be inserted into a CSS selector,
    # an XPath, or an ID.
    #
    def initialize(browser, line_number, line_type = 'data')
      super(browser)

      @field_type = line_type
      @line_number = line_number
      @line_identifier = line_number -1

      case @field_type
        when "leader"
          yaml_file = 'leader_line.yml'
        when "control"
          yaml_file = 'control_line.yml'
        when "data"
          yaml_file = 'data_line.yml'
        else
          yaml_file = 'data_line.yml'
      end
      @yaml_file = yaml_file

      element_hash = load_yml('/olels/objects/bib_editor_line/', @yaml_file)
      replace_identifiers(element_hash, /LINEID/, @line_identifier.to_s)
      set_elements(element_hash)
    end
  end
end