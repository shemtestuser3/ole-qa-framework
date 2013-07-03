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

module OLE_QA::Framework
  # A Data Object in OLE that represents a line nested under another line.
  # A subline can usually be added or deleted, and has element identifiers
  # which vary dependent upon the line below which they are nested.
  class Subline_Object < Data_Object

    # The line number that this object will have on the screen.
    # - Used for line identifier replacement.
    attr_reader :line_number
    attr_reader :line_id

    # The line number that this subline object will have on the screen.
    # - Used for subline identifier replacement.
    attr_reader :subline_number
    attr_reader :subline_id

    # @param ole_session [Object] The OLE_QA::Framework::Session session to pass to the Data Object.
    # @param line_number [Fixnum] The line number this subline object will use for element definitions.
    # @param subline_number [Fixnum] The subline number this subline object will use for element definitions.
    def initialize(ole_session, line_number = 1, subline_number = 1)
      @line_number, @subline_number = line_number, subline_number
      @line_id = line_number -1
      @subline_id = subline_number -1
      super(ole_session)
    end

    # Set elements on the subline object.
    # @note Use line_number, line_id, subline_number, and subline_id to replace dynamic identifier numbers.
    #   (See {OLE_QA::Framework::Line_Object#set_elements} for more on line number substitution.)
    def set_elements
    end
  end
end