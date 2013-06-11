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
  # The OLE Library System MARC Item Record Editor Screen
  class Item_Editor < Editor

    # An integer counter for the number of Item Notes lines in the Extended Information section
    attr_accessor :item_note_counter

    def initialize(browser, olels_url)
      super(browser, olels_url)

      @item_note_counter = 1
      make_accessor (:item_note_1)
      @item_note_1 = Editor_Note.new(@browser, 'item note', 1)

      elements = load_yml('/olels/pages/item_editor/','elements.yml')
      set_elements(elements)
    end

    # Open the bibliographic record editor (Bib Editor).
    # @note There are no direct links to the item editor.
    def open
      super
      frame_select
    end

    # Add an item note and increment the counter.
    # - Optionally click the .add_button element.
    def add_item_note(do_click = true)
      c = @item_note_counter
      current_line = instance_variable_get(:"@item_note_#{c}")
      current_line.add_button.click if do_click
      @item_note_counter += 1
      c += 1
      make_accessor(:"item_note_#{c}")
      instance_variable_set(:"@item_note_#{c}",\
        Editor_Note.new(@browser, 'item note', c))
    end

    def delete_item_note(which, do_click = true)
      c = @item_note_counter
      raise StandardError, "Note does not exist!" if which > c
      current_line = instance_variable_get(:"@item_note_#{which}")
      current_line.remove_button.click if do_click
      remove_instance_variable(:"@item_note_#{c}") unless c == 1
      @item_note_counter -= 1 unless c == 1
    end
  end
end