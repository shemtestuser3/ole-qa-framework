0#  Copyright 2005-2013 The Kuali Foundation
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
  # A single line on an OLE Financial System Receiving Document
  class Receiving_Line < OLE_QAF::Line_Object

    # An integer counter for the number of Exception Notes Lines.
    attr_accessor :exception_notes_line_counter

    # An integer counter for the number of Receipt Notes Lines.
    attr_accessor :receipt_notes_line_counter

    # An integer counter for the number of Special Processing Instructions Lines.
    attr_accessor :processing_line_counter

    # An integer counter for the number of Copies Lines.
    attr_accessor :copies_line_counter

    def initialize(browser, line_number, new_line = true)
      @yaml_path = '/olefs/objects/receiving_line/'
      @browser = browser
      @line_number = line_number
      @new_line = new_line
      super(@browser, @yaml_path, @line_number, @new_line)

      @exception_notes_line_counter = 0
      @receipt_notes_line_counter = 0
      @processing_line_counter = 0
      @copies_line_counter = 0

      # @note A new_processing_line instance will not be created for
      # a Special Processing Instructions Line, as these lines
      # are only added on requisitions and purchase orders as a
      # special type of Notes Line.
      unless new_line
        make_accessor(:new_exception_notes_line)
        @new_exception_notes_line = Exception_Notes_Line.new(@browser, @line_number, 0)
        make_accessor(:new_receipt_notes_line)
        @new_receipt_notes_line = Receipt_Notes_Line.new(@browser, @line_number, 0)
        make_accessor(:new_copies_line)
        @new_copies_line = Copies_Line.new(@browser, @line_number, 0)
      end
    end

    # Create an exception notes line object on the current receiving line instance.
    # - Increments the exception notes line counter.
    # - Creates a new instance of Exception_Notes_Line.
    # - New instance variable will be @exception_notes_line_N where N = counter.
    def create_exception_notes_line
      @exception_notes_line_counter += 1
      n = @exception_notes_line_counter
      new_line = false
      make_accessor(:"exception_notes_line_#{n}")
      instance_variable_set(:"@exception_notes_line_#{n}", \
        Exception_Notes_Line.new(@browser, @line_number, n, new_line))
    end

    # Delete the highest-numbered exception notes line object on the current receiving line instance.
    # - Removes the @exception_notes_line_N instance variable where N = counter.
    # - Decrements the exception notes line counter.
    #
    # @raise [StandardError] if counter = 0
    def delete_exception_notes_line
      n = @exception_notes_line_counter
      raise StandardError, "No exception notes lines exist!" if n == 0
      remove_instance_variable(:"@exception_notes_line_#{n}")
      @exception_notes_line_counter -= 1
    end

    # Create an receipt notes line object on the current receiving line instance.
    # - Increments the receipt notes line counter.
    # - Creates a new instance of Receipt_Notes_Line.
    # - New instance variable will be @receipt_notes_line_N where N = counter.
    def create_receipt_notes_line
      @receipt_notes_line_counter += 1
      n = @receipt_notes_line_counter
      new_line = false
      make_accessor(:"receipt_notes_line_#{n}")
      instance_variable_set(:"@receipt_notes_line_#{n}", \
          Receipt_Notes_Line.new(@browser, @line_number, n, new_line))
    end
  
    # Delete the highest-numbered receipt notes line object on the current receiving line instance.
    # - Removes the @receipt_notes_line_N instance variable where N = counter.
    # - Decrements the receipt notes line counter.
    #
    # @raise [StandardError] if counter = 0
    def delete_receipt_notes_line
      n = @receipt_notes_line_counter
      raise StandardError, "No receipt notes lines exist!" if n == 0
      remove_instance_variable(:"@receipt_notes_line_#{n}")
      @receipt_notes_line_counter -= 1
    end
  
    # Create an processing line object on the current receiving line instance.
    # - Increments the processing line counter.
    # - Creates a new instance of Processing_Line.
    # - New instance variable will be @processing_line_N where N = counter.
    def create_processing_line
      @processing_line_counter += 1
      n = @processing_line_counter
      new_line = false
      make_accessor(:"processing_line_#{n}")
      instance_variable_set(:"@processing_line_#{n}", \
          Processing_Line.new(@browser, @line_number, n, new_line))
    end
  
    # Delete the highest-numbered processing line object on the current receiving line instance.
    # - Removes the @processing_line_N instance variable where N = counter.
    # - Decrements the processing line counter.
    #
    # @raise [StandardError] if counter = 0
    def delete_processing_line
      n = @processing_line_counter
      raise StandardError, "No processing lines exist!" if n == 0
      remove_instance_variable(:"@processing_line_#{n}")
      @processing_line_counter -= 1
    end

    # Create an copies line object on the current receiving line instance.
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

    # Delete the highest-numbered copies line object on the current receiving line instance.
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

  end
end