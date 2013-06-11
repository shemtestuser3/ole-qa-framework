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
  # A Special Processing Instructions Line in an OLE Financial System Receiving Document.
  class Processing_Line < OLE_QAF::Subline_Object

    # browser
    #   OLE_QAF::Framework.browser instance
    #
    # line_number
    #   numerical value for the receiving line number
    #   after it has been added
    #   (Human Readable)
    #
    # subline_number
    #   numerical value for this object after being added
    #   (Human Readable)
    #
    # new_line = true|false
    #   whether the line being created represents a new line or a
    #   pre-existing line
    #   default = false
    #   @note Special Processing Instructions Notes are only created on
    #   requisition documents and purchase order documents, they
    #   cannot be created on receiving documents themselves, so
    #   this value is unlikely to be needed.
    def initialize(ole_browser, line_number, subline_number, new_line = false)
      yaml_path = "/olefs/objects/processing_line/"
      super(ole_browser, yaml_path, line_number, subline_number, new_line)
    end
  end
end