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

module OLE_QAF::OLEFS
  # A single Line Item in an OLE Financial System PURAP E-Document.
  class Line_Item < OLE_QAF::Line_Object

    # An integer counter for the number of Accounting Lines attached to the Line Item.
    # - This counter always points at the new accounting line, the first under the item.
    # - This counter always represents the sum of available accounting lines on the screen, not the sum of added lines.
    attr_accessor :accounting_line_counter

    # An integer counter for the number of Copies Lines attached to the Line Item.
    # - This counter always points at the new copies line, the first under the item.
    # - This counter always represents the sum of visible copies lines on the screen, not the sum of added lines.
    # - The presence of actual copies lines in OLE is dependent upon the number of copies listed in the Line Item.
    # - For simplicity's sake, this counter will be set to 1 when the Line Item is added.  It will not be state-dependent.
    attr_accessor :copies_line_counter

    # An integer counter for the number of Notes Lines attached to the Line Item.
    # - This counter always points at the new notes line, the first under the item.
    # - This counter always represents the sum of visible notes lines on the screen, not the sum of added lines.
    attr_accessor :notes_line_counter

    def initialize(browser, line_number, new_line = true)
      @yaml_path = '/olefs/objects/line_item/'
      @browser = browser
      @line_number = line_number
      @new_line = new_line
      super(@browser, @yaml_path, @line_number, @new_line)

      @accounting_line_counter = 0
      @copies_line_counter = 0
      @notes_line_counter = 0

      unless new_line
        make_accessor(:new_accounting_line)
        @new_accounting_line = Accounting_Line.new(@browser, @line_number, 0)
        make_accessor(:new_copies_line)
        @new_copies_line = Copies_Line.new(@browser, @line_number, 0)
        make_accessor(:new_notes_line)
        @new_notes_line = Notes_Line.new(@browser, @line_number, 0)
      end
    end

    # Create an accounting line object on the current line item instance.
    # - Increments the accounting line counter.
    # - Creates a new instance of Accounting_Line.
    # - New instance variable will be @accounting_line_N where N = counter.
    def create_accounting_line
      @accounting_line_counter += 1
      n = @accounting_line_counter
      new_line = false
      make_accessor(:"accounting_line_#{n}")
      instance_variable_set(:"@accounting_line_#{n}", \
        Accounting_Line.new(@browser, @line_number, n, new_line))
    end

    # Delete the highest-numbered accounting line object on the current line item instance.
    # - Removes the @accounting_line_N instance variable where N = counter.
    # - Decrements the accounting line counter.
    #
    # @raise [StandardError] if counter = 0
    def delete_accounting_line
      n = @accounting_line_counter
      raise StandardError, "No accounting lines exist!" if n == 0
      remove_instance_variable(:"@accounting_line_#{n}")
      @accounting_line_counter -= 1
    end

    # Create an copies line object on the current line item instance.
    # - Increments the copies line counter.
    # - Creates a new instance of Copies_Line.
    # - New instance variable will be @copies_line_N where N = counter.
    def create_copies_line
      @copies_line_counter += 1
      n = @copies_line_counter
      new_line = false
      make_accessor(:"copies_line_#{n}")
      instance_variable_set(:"@copies_line_#{n}", \
        Copies_Line.new(@browser, @line_number, n, new_line))
    end

    # Delete the highest-numbered copies line object on the current line item instance.
    # - Removes the @copies_line_N instance variable where N = counter.
    # - Decrements the copies line counter.
    #
    # @raise [StandardError] if counter = 0
    def delete_copies_line
      n = @copies_line_counter
      raise StandardError, "No copies lines exist!" if n == 0
      remove_instance_variable(:"@copies_line_#{n}")
      @copies_line_counter -= 1
    end

    # Create an notes line object on the current line item instance.
    # - Increments the notes line counter.
    # - Creates a new instance of Notes_Line.
    # - New instance variable will be @notes_line_N where N = counter.
    def create_notes_line
      @notes_line_counter += 1
      n = @notes_line_counter
      new_line = false
      make_accessor(:"notes_line_#{n}")
      instance_variable_set(:"@notes_line_#{n}", \
        Notes_Line.new(@browser, @line_number, n, new_line))
    end

    # Delete the highest-numbered notes line object on the current line item instance.
    # - Removes the @notes_line_N instance variable where N = counter.
    # - Decrements the notes line counter.
    #
    # @raise [StandardError] if counter = 0
    def delete_notes_line
      n = @notes_line_counter
      raise StandardError, "No notes lines exist!" if n == 0
      remove_instance_variable(:"@notes_line_#{n}")
      @notes_line_counter -= 1
    end
    
  end
end