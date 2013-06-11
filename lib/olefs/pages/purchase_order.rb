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
  # An OLE Financial System Purchase Order
  # - Many screen elements are identical to those of a Requisition
  # - Line Item handling is identical to that of a Requisition
  class Purchase_Order < Requisition

    def initialize(ole_browser, olefs_url)
      # Purchase Orders do not have a special URL for opening new
      # documents, and are only created by approving requisitions.
      # Inheriting the purap_requisition URL is not ideal for consistency,
      # but it is ideal for functionality.
      super(ole_browser, olefs_url)

      subdir = '/olefs/pages/purchase_order/'

      # Loading PO elements will redefine some Requisition elements
      po_elements = load_elements(subdir)
      set_elements(po_elements)
    end
  end
end