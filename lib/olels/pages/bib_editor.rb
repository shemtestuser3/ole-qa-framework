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
  # The OLE Library System MARC Bibliographic Record Editor Screen
  class Bib_Editor < Editor

    # An integer counter for the number of MARC Data Lines on the screen.
    attr_accessor :data_line_counter

    # An integer counter for the number of MARC Control Lines on the screen.
    attr_accessor :control_line_counter

    # The default Leader Field Line, automatically generated upon instantiation.
    # In OLE, this line has only a single field (leader_line.value_field),
    # and is a required field for a MARC record, but will take any alphanumeric
    # placeholder text (may not support punctuation or special characters).
    #
    attr_accessor :leader_line

    # The default Control Field line created when the Bib Editor is opened.
    #
    # The safe placeholder value for the control field tag (control_line_1.tag_field)
    # is "008".  Any alphanumeric value can be used as a testing placeholder for
    # the control field value (control_line_1.value_field), but no punctuation
    # or special characters should be used.
    #
    # When the Bib Record is saved (.save), a new control line will be added with
    # a tag of "001" and a hyphenated alphanumeric string representing the UUID
    # of the record in the DocStore.  This value will supplant control_line_1,
    # and the script will increment the control_line_counter and add control_line_2,
    # which will contain the original value entered for the control field.
    #
    attr_accessor :control_line_1

    # The default Data Field line created when the Bib Editor is opened.
    #
    # The minimum requirements to save a Bibliographic Record include a title
    # (tag "245", subfield "|a", any alphanumeric value), a leader field
    # value (see leader_line), and a control field value (see control_line_1).
    #
    # If a minimum-requirement bib is being created, use data_line_1 to create
    # a 245 $a MARC field.
    #
    attr_accessor :data_line_1

    def initialize(browser, olels_url)
      super(browser, olels_url)

      @data_line_counter = 1
      @control_line_counter = 1

      # Create a line for the Leader Field (Required)
      @leader_line = Bib_Editor_Line.new(@browser, 1, 'leader')
      # Create a line for the Control Field (Required, 008)
      @control_line_1 = Bib_Editor_Line.new(@browser, 1, 'control')
      # Create a line for the first Data Field (Required, 245, |a)
      @data_line_1 = Bib_Editor_Line.new(@browser, 1, 'data')

      # Load Bib Editor Elements
      elements = load_elements('/olels/pages/bib_editor/')
      set_elements(elements)
    end

    # Open the Bib Editor via URL and select the frame "iframeportlet".
    def open
      super
      frame_select
    end

    # Add a data line and increment the counter (data_line_counter).
    # Creates a new instance variable named data_line_N, where
    # N = @data_line_counter + 1.
    #
    def add_data_line(do_click = true)
      if instance_variable_defined?(:"@data_line_#{@data_line_counter}") then
        current_line = instance_variable_get(:"@data_line_#{@data_line_counter}")
        current_line.add_button.click if do_click
        @data_line_counter += 1
        make_accessor(:"data_line_#{@data_line_counter}")
        instance_variable_set(:"@data_line_#{@data_line_counter}",\
         Bib_Editor_Line.new(@browser, @data_line_counter, 'data'))
      else
        raise StandardError, "Data Line not set: data_line_#{@data_line_counter}"
      end
    end

    # Add a control line and increment the counter (control_line_counter).
    # Creates a new instance variable named control_line_N, where
    # N = @control_line_counter + 1.
    #
    def add_control_line(do_click = true)
      if instance_variable_defined?(:"@control_line_#{@control_line_counter}") then
        current_line = instance_variable_get(:"@control_line_#{@control_line_counter}")
        current_line.add_button.click if do_click
        @control_line_counter += 1
        make_accessor(:"control_line_#{@control_line_counter}")
        instance_variable_set(:"@control_line_#{@control_line_counter}",\
         Bib_Editor_Line.new(@browser, @control_line_counter, 'control'))
      else
        raise StandardError, "Control Line not set: control_line_#{@control_line_counter}"
      end
    end

    # Remove a control line by number.  If this leaves one too many
    # control line instances, remove the last one.
    #
    # NB! - You'll need to use a conditional wait or a spin assert
    # after running this method to manipulate control lines altered
    # by this method.
    # If you start working with them before the screen elements have
    # time to refresh, they will show outdated values.
    #
    def delete_control_line(line_number, do_click = true)
      if instance_variable_defined?(:"@control_line_#{line_number}") then
        # Click the remove button.
        current_line = instance_variable_get(:"@control_line_#{line_number}")
        current_line.remove_button.click if do_click
        # Remove and reinstantiate all but the last control_line_N instance
        # variables.  The last one is dropped, and all of the values will
        # be shifted downward.
        line_number.upto(@control_line_counter) do |i|
          remove_instance_variable(:"@control_line_#{i}")
          unless i == @control_line_counter
            make_accessor(:"control_line_#{i}")
            instance_variable_set(:"@control_line_#{i}", Bib_Editor_Line.new(@browser, i, 'control'))
          end
        end
        # Finally, decrement the control line counter.
        @control_line_counter -= 1 unless @control_line_counter == 1
      else
        raise StandardError, "Control Line not set: control_line_#{line_number}"
      end
    end

    # Remove a data line by number.  If this leaves one too many
    # data field instances, remove the last one.
    #
    # NB! - You'll need to use a conditional wait or a spin assert
    # after running this method to manipulate control lines altered
    # by this method.
    # If you start working with them before the screen elements have
    # time to refresh, they will show outdated values.
    #
    def delete_data_line(line_number, do_click = true)
      if instance_variable_defined?(:"@data_line_#{line_number}") then
        # Click the remove button.
        current_line = instance_variable_get(:"@data_line_#{line_number}")
        current_line.remove_button.click if do_click
        # Remove and reinstantiate all but the last data_line_N instance
        # variables.  The last one is dropped, and all of the values will
        # be shifted downward.
        line_number.upto(@data_line_counter) do |i|
          remove_instance_variable(:"@data_line_#{i}")
          unless i == @data_line_counter
            make_accessor(:"data_line_#{i}")
            instance_variable_set(:"@data_line_#{i}", Bib_Editor_Line.new(@browser, i, 'control'))
          end
        end
        # Finally, decrement the control line counter.
        @data_line_counter -= 1 unless @data_line_counter == 1
      else
        raise StandardError, "Control Line not set: data_line_#{line_number}"
      end
    end

    # Click the submit button and increment the number of control lines
    # by 1.
    #
    # This method may also require a conditional wait or a spin assert in
    # order to assure that the new control line has appeared.
    def save
      @submit_button.click
      @control_line_counter += 1
      make_accessor(:"control_line_#{@control_line_counter}")
      instance_variable_set(:"@control_line_#{@control_line_counter}", \
        Bib_Editor_Line.new(@browser, @control_line_counter, 'control'))
    end

  end

end