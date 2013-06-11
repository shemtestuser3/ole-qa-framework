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

  # Any of Various Notes which Appear on the OLE Library System Instance Editor
  class Editor_Note < OLE_QAF::Data_Object

    # The type of Instance Note represented by an instance of this object.
    attr_accessor :note_type

    # The line number of an instance of this object.
    attr_accessor :line_number

    # The subline number of an instance of this object.
    # - Set to 0 by default.
    # - 0 indicates that an instance is not a subline element.
    # - Used when note_type = 'ownership note'.
    attr_accessor :subline_number

    # The YAML element definitions file loaded by an instance of this class.
    attr_accessor :yaml_file

    # @note Subline Number is only necessary when instantiating for a note type which represents a subline element.
    #  e.g., ownership_note = OLE_QAF::OLELS::Editor_Note.new(browser, 'ownership note', 2, 1)
    #  Otherwise leave this set to 0.
    def initialize(browser, note_type, line_number, subline_number = 0)
      super(browser)

      @line_number = line_number
      @line_identifier = line_number - 1
      @subline_number = subline_number
      @subline_identifier = subline_number - 1
      @note_type = note_type

      subdir = '/olels/objects/editor_note/'

      case @note_type
        when 'access info'
          yaml_file = 'access_info.yml'
        when 'holdings note'
          yaml_file = 'holdings_note.yml'
        when 'item note'
          yaml_file = 'item_note.yml'
        when 'ownership note'
          yaml_file = 'ownership_note.yml'
      end
      @yaml_file = yaml_file

      note_elements = load_yml(subdir, yaml_file)
      parse_elements(note_elements)
      set_elements(note_elements)
    end

    # Replace element identifiers in a series of element hashes.
    # - Replace LINEID with @line_identifier
    # - Replace LINENUM with @line_number
    # - Replace SUBLINEID with @subline_identifier
    # - Replace SUBLINENUM with @subline_number
    def parse_elements(element_hash)
      replace_identifiers(element_hash, /SUBLINEID/, @subline_identifier.to_s)
      replace_identifiers(element_hash, /SUBLINENUM/, @subline_number.to_s)
      replace_identifiers(element_hash, /LINEID/, @line_identifier.to_s)
      replace_identifiers(element_hash, /LINENUM/, @line_number.to_s)
    end

  end
end