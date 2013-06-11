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
  # A single Line Item in an OLE Financial System Payment Request.
  class PREQ_Line_Item < OLE_QAF::Line_Object

    # An integer counter for the number of Accounting Lines attached to the Line Item.
    # - This counter always points at the new accounting line, the first under the Line Item.
    # - This counter always represents the sum of available accounting lines on the Line Item.
    attr_accessor :accounting_line_counter

    # An integer counter for the number of Invoice Notes Lines attached to the Line Item.
    # - This counter always points at the new invoice notes line, the first under the Line Item.
    # - This counter always represents the sum of available invoice notes lines on the Line Item.
    attr_accessor :invoice_notes_line_counter

    def initialize(browser, line_number, new_line = true)
      @yaml_path = '/olefs/objects/preq_line_item/'
      @browser = browser
      @line_number = line_number
      @new_line = new_line
      super(@browser, @yaml_path, @line_number, @new_line)
      
      @accounting_line_counter = 0
      @invoice_notes_line_counter = 0

      unless new_line
        make_accessor(:new_accounting_line)
        @new_accounting_line = Accounting_Line.new(@browser, @line_number, 0)
        make_accessor(:new_invoice_notes_line)
        @new_invoice_notes_line = Invoice_Notes_Line.new(@browser, @line_number, 0)
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

    # Create an invoice notes line object on the current line item instance.
    # - Increments the invoice notes line counter.
    # - Creates a new instance of Invoice_Notes_Line.
    # - New instance variable will be @invoice_notes_line_N where N = counter.
    def create_invoice_notes_line
      @invoice_notes_line_counter += 1
      n = @invoice_notes_line_counter
      new_line = false
      make_accessor(:"invoice_notes_line_#{n}")
      instance_variable_set(:"@invoice_notes_line_#{n}", \
        Invoice_Notes_Line.new(@browser, @line_number, n, new_line))
    end

    # Delete the highest-numbered invoice notes line object on the current line item instance.
    # - Removes the @invoice_notes_line_N instance variable where N = counter.
    # - Decrements the invoice notes line counter.
    #
    # @raise [StandardError] if counter = 0#
    def delete_invoice_notes_line
      n = @invoice_notes_line_counter
      raise StandardError, "No invoice lines exist!" if n == 0
      remove_instance_variable(:"@invoice_notes_line_#{n}")
      @invoice_notes_line_counter -= 1
    end
  end
end