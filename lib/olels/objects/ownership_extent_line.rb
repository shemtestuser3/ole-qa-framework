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
  # An Extent of Ownership Line on the OLE Library System Instance Editor.
  class Ownership_Extent_Line < OLE_QAF::Data_Object

    # An integer counter for the number of ownership notes attached to the Ownership Extent Line.
    attr_accessor :ownership_notes_counter

    # The sequential position of a given instance of this Ownership Extent Line.
    # - Used to replace LINENUM in Xpaths and CSS selectors based on human-readable elements.
    # - Used to replace LINEID in element identifiers, Xpaths, and CSS selectors not based on human-readable elements.
    attr_accessor :line_number

    def initialize(browser, line_number)
      super(browser)

      @line_number = line_number
      @line_identifier = line_number - 1

      elements = load_yml('/olels/objects/ownership_extent_line/', 'elements.yml')
      parse_elements(elements)
      set_elements(elements)

      @ownership_notes_counter = 1
      make_accessor(:ownership_note_1)
      @ownership_note_1 = Editor_Note.new(@browser, 'ownership note', @line_number, 1)
    end

    # Take an element hash and replace LINEID and LINENUM in identifiers
    # with their numeric value equivalents.
    def parse_elements(element_hash)
      replace_identifiers(element_hash, /LINEID/, @line_identifier.to_s)
      replace_identifiers(element_hash, /LINENUM/, @line_number.to_s)
    end

    # Add an ownership note and increment the counter.
    # - Optionally click the .add_button element.
    def add_ownership_note(do_click = true)
      c = @ownership_notes_counter
      current_line = instance_variable_get(:"@ownership_note_#{c}")
      current_line.add_button.click if do_click
      @ownership_notes_counter += 1
      c += 1
      make_accessor(:"ownership_note_#{c}")
      instance_variable_set(:"@ownership_note_#{c}",\
        Editor_Note.new(@browser, 'ownership note',@line_number, c))
    end

    # Remove an ownership note from the page object and decrement the counter.
    # - Optionally clicks the .remove_button element on the target line.
    # - Will delete the highest-numbered line instance on the page object unless it is 1.
    # - Defaults to the highest-numbered line instance
    def delete_ownership_note(which, do_click = true)
      c = @ownership_notes_counter
      raise StandardError, "Note does not exist!" if which > c
      current_line = instance_variable_get(:"@ownership_note_#{which}")
      current_line.remove_button.click if do_click
      remove_instance_variable(:"@ownership_note_#{c}") unless c == 1
      @ownership_notes_counter -= 1 unless c == 1
    end
  end
end
