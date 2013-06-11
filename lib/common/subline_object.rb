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

module OLE_QAF
  # A Data Object in OLE that represents a line nested under another line.
  # A subline can usually be added or deleted, and has element identifiers
  # which vary dependent upon the line below which they are nested.
  class Subline_Object < Line_Object

    # Line number that the subline will have after being added.
    attr_accessor :subline_number

    # Line number that subline element identifiers will have after being added.
    # (@subline_number - 1)
    attr_accessor :subline_identifier

    # Indicates whether the new.yml or added.yml elements file should be loaded.
    attr_accessor :new_line

    # Assume that the YAML path will contain two files:
    #   - new.yml
    #   - added.yml
    #
    # The identifier strings of each YML file will be parsed
    # for variable substitution upon load.  The following text
    # values will undergo substitution.
    #
    #   LINENUM             -- This will be replaced with line_number, as in Line Object.
    #   LINEID              -- This will be replaced with line_identifier, as in Line Object.
    #   SUBLINENUM          -- This will be replaced with subline_number.
    #   SUBLINEID           -- This will be replaced with subline_identifier.
    #
    # The following variables will be used to perform these substitutions
    # in order to identify the position of screen elements within the DOM:
    #
    #   line_number = 1         -- This is the human-readable value representing
    #                               which line the given subline object belongs to.
    #
    #   line_identifier = 0     -- This is the value used for element IDs
    #                               representing which line the given subline object
    #                               belongs to.
    #
    #   subline_number = 1      -- This is the human readable value representing
    #                               which subline the given subline object belongs to.
    #
    #   subline_identifier = 0  -- This is the value used for element IDs representing
    #                               which subline the given subline object belongs to.
    #
    # browser
    #   OLE_QAF::Framework.browser
    #   (Selenium::WebDriver::Driver instance)
    #
    # yaml_path
    #   path to the files new.yml & added.yml, containing differing
    #   element definitions for the line item object in both new and added
    #   states
    #
    # line_number
    #   the number of the line item to which the subline belongs
    #   this is the 1-based sequential number of the line object
    #   used by human-readable elements on the screen, and it is
    #   used by the subline_object to identify screen elements
    #
    # subline_number
    #   the number the subline item will have in the added state
    #   this is also a 1-based sequential number used by human-
    #   readable identifiers on the screen
    #   (internal identifiers are 0-based)
    def initialize(browser, yaml_path, line_number, subline_number = 1, new_line = true)
      @browser = browser
      @yaml_path = yaml_path
      @line_number = line_number
      @line_identifier = line_number -1
      @subline_number = subline_number
      @subline_identifier = subline_number -1

      @new_line = new_line

      if @new_line then
        subline_elements = load_yaml(@yaml_path, 'new.yml')
      else
        subline_elements = load_yaml(@yaml_path, 'added.yml')
      end
      parse_elements(subline_elements)
      set_elements(subline_elements)
    end

    # Alias a question-marked accessor for the new_line instance variable.
    def new_line?
      @new_line
    end

    # Take an element hash and replace SUBLINEID and SUBLINENUM in identifiers
    # with their numberic value equivalents.
    # Call parse_elements on the superclass
    def parse_elements(element_hash)
      replace_identifiers(element_hash, /SUBLINEID/, @subline_identifier.to_s)
      replace_identifiers(element_hash, /SUBLINENUM/, @subline_number.to_s)
      super(element_hash)
    end
  end
end