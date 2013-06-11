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

  # A Data Object in OLE that represents a single line in a given area.
  # A line object can usually be added or deleted, and may or may not
  # have its own line objects beneath it in the page-object hierarchy.
  class Line_Object < Data_Object

    # Path to the YAML configuration files for the line object.
    attr_accessor :yaml_path

    # Line number that the line object will have after being added.
    attr_accessor :line_number

    # Line number that element identifiers will have after line object is added.
    # (@line_number - 1)
    attr_accessor :line_identifier

    # Indicates whether the new.yml or added.yml elements file should be loaded.
    attr_accessor :new_line

    # Assumes that the YAML path will contain two files:
    #   - new.yml
    #   - added.yml
    #
    # The identifier strings of each YML file will be parsed
    # for variable substitution upon load.  The following text
    # values will undergo substitution.
    #
    #   LINENUM               -- This will be replaced with line_number.
    #   LINEID                -- This will be replaced with line_identifier.
    #
    # The following variables will be used to perform these substitutions
    # in order to identify the position of screen elements within the DOM:
    #
    #   line_number = 1       -- This is the human-readable value representing
    #                             which line the given line object belongs to.
    #
    #   line_identifier = 0   -- This is the value used for element IDs
    #                             representing which line the given line object
    #                             belongs to.
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
    #   the number the line will have in the added state
    #   this is the 1-based sequential number of the line object
    #   used by human-readable identifiers on screen
    #   (the internal element identifiers are 0-based)
    #
    # new_line
    #   the boolean value of whether or not the line should be populated
    #   in a new state
    def initialize(browser, yaml_path, line_number = 1, new_line = true)
      super(browser)

      @yaml_path = yaml_path
      @line_number = line_number
      @line_identifier = line_number -1

      @new_line = new_line

      if @new_line then
        line_elements = load_yml(@yaml_path, 'new.yml')
      else
        line_elements = load_yml(@yaml_path, 'added.yml')
      end
      parse_elements(line_elements)
      set_elements(line_elements)
    end

    # Alias a question-marked accessor for the new_line boolean instance variable.
    def new_line?
      @new_line
    end

    # Take an element hash and replace LINEID and LINENUM in identifiers
    # with their numeric value equivalents.
    def parse_elements(element_hash)
      replace_identifiers(element_hash, /LINEID/, @line_identifier.to_s)
      replace_identifiers(element_hash, /LINENUM/, @line_number.to_s)
    end
  end
end