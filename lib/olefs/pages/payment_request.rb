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
  # An OLE Financial System Payment Request Document.
  class Payment_Request < PURAP_Document

    def initialize(ole_browser, olefs_url)
      super(ole_browser, olefs_url)

      subdir = '/olefs/pages/payment_request/'
      preq_elements = load_elements(subdir)
      set_elements(preq_elements)

      @url = olefs_url + 'portal.do?channelTitle=Payment Request&channelUrl=selectOlePaymentRequest.do?methodToCall=docHandler&command=initiate&docTypeName=OLE_PREQ'

      # Redefine new line item instance variable set by PURAP document.
      @new_line_item = PREQ_Line_Item.new(@browser, 0, new_line = true)
    end

    # Create a new line item on the current Payment Request instance.
    # - Increments the line item counter.
    # - Creates a new instance of Line_Item.
    # - New instance variable will be @line_item_N where N = counter.
    def create_line_item
      @line_item_counter += 1
      n = @line_item_counter
      new_line = false
      make_accessor(:"line_item_#{n}")
      instance_variable_set(:"@line_item_#{n}",\
        PREQ_Line_Item.new(@browser, n, new_line))
    end

    # Delete the highest-numbered line item object on the current Payment Request instance.
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