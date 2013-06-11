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

module OLE_QAF::Data_Helpers

  # Replace the identifier strings in an element hash.
  # See OLE_QAF::Helpers.set_elements(element_hash) for an example hash format.
  #
  #   element_hash = {}
  #   match_pattern = /LINEID/
  #   new_value = @line_identifier
  #
  # @raise StandardError if not given appropriately-formatted parameters.
  #
  def replace_identifiers(element_hash, match_pattern, new_value)
    raise StandardError, "Object given is not an element hash. Given: #{element_hash.class}" unless element_hash.class == Hash
    raise StandardError, "Object given is not a match pattern. Given: #{match_pattern}" unless match_pattern.class == Regexp
    raise StandardError, "Object given is not a string. Given: #{new_value}" unless new_value.class == String
    element_hash.each do |k,v|
      element_hash[k][2] = v[2].gsub(match_pattern, new_value)
    end
  end

  # Replace the keys in an element hash according to match patterns.
  # This will change the names of the instance variables created
  # when a given element hash is instantiated with
  # OLE_QAF::Helpers.set_elements(element_hash).
  #
  # See OLE_QAF::Helpers.set_elements(element_hash) for an example hash format.
  #
  #   element_hash = {}
  #   match_pattern = /LINEID/
  #   new_value = @line_identifier
  #
  # @raise StandardError if not given appropriately-formatted parameters.
  #
  def replace_names(element_hash, match_pattern, new_value)
    raise StandardError, "Object given is not an element hash. Given: #{element_hash.class}" unless element_hash.class == Hash
    raise StandardError, "Object given is not a match pattern. Given: #{match_pattern}" unless match_pattern.class == Regexp
    raise StandardError, "Object given is not a string. Given: #{new_value}" unless new_value.class == String
    hsh2 = Hash.new
    element_hash.each do |k,v|
      k2 = k.to_s.gsub(match_pattern, new_value).to_sym
      hsh2[k2] = element_hash[k]
    end
    element_hash.replace(hsh2)
  end

end