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
  # An OLE Financial System Receiving Document
  class Receiving_Document < PURAP_Document

    # The number of receiving lines on the Receiving Document.
    # - Initializes to one.
    # - This is the value passed to the Receiving Line object upon instantiation.
    # - There will always be a .receiving_line_N accessor where N = counter.
    # - .receiving_line_N will always be the newest receiving line on the Receiving Document.
    # - The receiving line number stays with a receiving line after it is added.
    attr_accessor :receiving_line_counter

    # This is the first receiving line on the Receiving Document.
    # It starts out as a fully added line.  Each Receiving Document
    # must have at least one line.  To add additional lines, see
    # .add_receiving_line.
    #
    # @note As with a line item, a bibliographic record must be
    # created on a new receiving line before it can be added.
    attr_accessor :receiving_line_1

    # This is the first new receiving line on the Receiving Document.
    # It starts out with new line definitions, but can be added with
    # the .add_receiving_line method.
    #
    # @note Use .add_receiving_line(do_click = false) to add additional
    # lines to this Receiving Document in order to accurately model a
    # document expected to start with multiple lines.
    attr_accessor :receiving_line_2

    def initialize(ole_browser, olefs_url)
      url = olefs_url + 'portal.do?channelTitle=Receiving&channelUrl=selectOleLineItemReceiving.do?methodToCall=docHandler&command=initiate&docTypeName=OLE_RCVL'
      super(ole_browser, olefs_url)

      subdir = '/olefs/pages/receiving_document/'
      rcv_elements = load_elements(subdir)
      set_elements(rcv_elements)

      # Remove line item instance variables set by PURAP Document.
      remove_instance_variable(:@new_line_item)
      remove_instance_variable(:@line_item_counter)

      @receiving_line_counter = 0
      make_accessor(:new_receiving_line)
      @new_receiving_line = Receiving_Line.new(@browser, 0, new_line = true)
    end

    # Create a new receiving line on the current Receiving Document instance.
    # - Increments the receiving line counter.
    # - Creates a new instance of Receiving_Line.
    # - New instance variable will be @receiving_line_N where N = counter.
    def create_receiving_line
      @receiving_line_counter += 1
      n = @receiving_line_counter
      new_line = false
      make_accessor(:"receiving_line_#{n}")
      instance_variable_set(:"@receiving_line_#{n}",\
        Receiving_Line.new(@browser, n, new_line))
    end

    # Delete the highest-numbered receiving line object on the current Receiving Document instance.
    # - Removes the @receiving_line_N instance variable where N = counter.
    # - Decrements the receiving line counter.
    #
    # @raise [StandardError] if counter = 0
    def delete_receiving_line
      n = @receiving_line_counter
      raise StandardError, "No receiving lines exist!" if n == 0
      remove_instance_variable(:"@receiving_line_#{n}")
      @receiving_line_counter -= 1
    end
  end
end