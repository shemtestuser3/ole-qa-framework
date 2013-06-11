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
  # An OLE Financial System PURchasing/Accounts Payable Document
  class PURAP_Document < E_Doc

    include OLE_QAF::Page_Helpers

    # The URL to open a new PURAP document on the current OLE environment.
    attr_accessor :url

    # The number of line items on the PURAP document.
    # - Initializes to one.
    # - This is the value passed to the Line Item object upon instantiation.
    # - There will always be a .line_item_N accessor where N = counter.
    # - .line_item_N will always be the newest line item on the PURAP document.
    # - The line item number stays with a line item after it is added.
    attr_accessor :line_item_counter

    # This is the first line item on the PURAP document.
    # It starts out as a new line, yet to be added.
    #
    # @note In OLE, a bibliographic record must be attached to a line item
    # before it can be added.
    attr_accessor :line_item_1

    def initialize(ole_browser, olefs_url)
      super(ole_browser, olefs_url)

      subdir = '/olefs/common/purap_document/'

      purap_elements = load_elements(subdir)
      set_elements(purap_elements)

      @url = olefs_url

      @line_item_counter = 0
      make_accessor(:new_line_item)
      @new_line_item = Line_Item.new(@browser, 0, new_line = true)
    end

    # Create a new line item on the current PURAP Document instance.
    # - Increments the line item counter.
    # - Creates a new instance of Line_Item.
    # - New instance variable will be @line_item_N where N = counter.
    def create_line_item
      @line_item_counter += 1
      n = @line_item_counter
      new_line = false
      make_accessor(:"line_item_#{n}")
      instance_variable_set(:"@line_item_#{n}",\
        Line_Item.new(@browser, n, new_line))
    end

    # Delete the highest-numbered line item object on the current PURAP Document instance.
    # - Removes the @line_item_N instance variable where N = counter.
    # - Decrements the line item counter.
    #
    # @raise [StandardError] if counter = 0
    def delete_line_item
      n = @line_item_counter
      raise StandardError, "No line items exist!" if n == 0
      remove_instance_variable(:"@line_item_#{n}")
      @line_item_counter -= 1
    end
  end
end