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
  # The OLE Library System MARC Instance Record Editor Screen
  class Instance_Editor < Editor

    # An integer counter for the number of Extent of Ownership lines on the editor screen.
    attr_accessor :ownership_extent_line_counter

    # An integer counter for the number of Access Information notes lines on the editor screen.
    attr_accessor :access_info_line_counter

    # An integer counter for the number of Holdings Notes lines on the editor screen.
    attr_accessor :holdings_note_counter

    def initialize(browser, olels_url)
      super(browser, olels_url)

      @ownership_extent_line_counter = 1
      make_accessor(:ownership_extent_line_1)
      @ownership_extent_line_1 = Ownership_Extent_Line.new(@browser, 1)

      @access_info_line_counter = 1
      make_accessor(:access_info_line_1)
      @access_info_line_1 = Editor_Note.new(@browser, 'access info', 1)

      @holdings_note_counter = 1
      make_accessor(:holdings_note_1)
      @holdings_note_1 = Editor_Note.new(@browser, 'holdings note', 1)

      instance_editor_elements = load_yml('/olels/pages/instance_editor/', 'elements.yml')
      set_elements(instance_editor_elements)
    end

    # Open the bibliographic record editor (Bib Editor).
    # @note There are no direct links to the instance editor.
    def open
      super
      frame_select
    end

    # Add an ownership extent line and increment the counter.
    # - Optionally click the .add_button element on the highest line
    def add_ownership_extent_line(do_click = true)
      c = @ownership_extent_line_counter
      current_line = instance_variable_get(:"@ownership_extent_line_#{c}")
      current_line.add_button.click if do_click
      @ownership_extent_line_counter += 1
      c += 1
      make_accessor(:"ownership_extent_line_#{c}")
      instance_variable_set(:"@ownership_extent_line_#{c}",\
        Ownership_Extent_Line.new(@browser, c))
    end

    # Remove an ownership extent line from the page object and decrement the counter.
    # - Optionally clicks .remove_button element on target line.
    # - Will delete the highest-numbered line instance on the page object unless it is 1.
    def delete_ownership_extent_line(which, do_click = true)
      c = @ownership_extent_line_counter
      raise StandardError, "Line does not exist!" if which > c
      current_line = instance_variable_get(:"@ownership_extent_line_#{which}")
      current_line.remove_button.click if do_click
      remove_instance_variable(:"@ownership_extent_line_#{c}") unless c == 1
      @ownership_extent_line_counter -= 1 unless c == 1
    end

    # Add an access info line and increment the counter.
    # - Optionally click the .add_button element.
    def add_access_info_line(do_click = true)
      c = @access_info_line_counter
      current_line = instance_variable_get(:"@access_info_line_#{c}")
      current_line.add_button.click if do_click
      @access_info_line_counter += 1
      c += 1
      make_accessor(:"access_info_line_#{c}")
      instance_variable_set(:"@access_info_line_#{c}",\
        Editor_Note.new(@browser, 'access info', c))
    end

    # Remove an access info line from the page object and decrement the counter.
    # - Optionally clicks the .remove_button element on the target line.
    # - Will delete the highest-numbered line instance on the page object unless it is 1.
    def delete_access_info_line(which, do_click = true)
      c = @access_info_line_counter
      raise StandardError, "Line does not exist!" if which > c
      current_line = instance_variable_get(:"@acces_info_line_#{which}")
      current_line.remove_button.click if do_click
      remove_instance_variable(:"@access_info_line_#{c}") unless c == 1
      @access_info_line_counter -= 1 unless c == 1
    end

    # Add a holdings note and increment the counter.
    # - Optionally click the .add_button element.
    def add_holdings_note(do_click = true)
      c = @holdings_note_counter
      current_line = instance_variable_get(:"@holdings_note_#{c}")
      current_line.add_button.click if do_click
      @holdings_note_counter += 1
      c += 1
      make_accessor(:"holdings_note_#{c}")
      instance_variable_set(:"@holdings_note_#{c}",\
        Editor_Note.new(@browser, 'holdings note', c))
    end

    # Remove a holdings note from the page object and decrement the counter.
    # - Optionally clicks the .remove_button element on the target line.
    # - Will delete the highest-numbered line instance on the page object unless it is 1.
    def delete_holdings_note(which, do_click = true)
      c = @holdings_note_counter
      raise StandardError, "Note does not exist!" if which > c
      current_line = instance_variable_get(:"@holdings_note_#{which}")
      current_line.remove_button.click if do_click
      remove_instance_variable(:"@holdings_note_#{c}") unless c == 1
      @holdings_note_counter -= 1 unless c == 1
    end
  end
end